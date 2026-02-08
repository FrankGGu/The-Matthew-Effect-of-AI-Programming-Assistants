package main

import (
	"sort"
)

const MAX_XOR_BITS = 30 // Since weights are up to 10^9, which is < 2^30

type LinearBasis struct {
	basis [MAX_XOR_BITS]int
}

func (lb *LinearBasis) Insert(val int) {
	for i := MAX_XOR_BITS - 1; i >= 0; i-- {
		if (val>>i)&1 == 0 {
			continue
		}
		if lb.basis[i] == 0 {
			lb.basis[i] = val
			return
		}
		val ^= lb.basis[i]
	}
}

func (lb *LinearBasis) Query(val int) bool {
	for i := MAX_XOR_BITS - 1; i >= 0; i-- {
		val = min(val, val^lb.basis[i])
	}
	return val == 0
}

func (lb *LinearBasis) Copy() *LinearBasis {
	newLb := &LinearBasis{}
	copy(newLb.basis[:], lb.basis[:])
	return newLb
}

type DSU struct {
	parent     []int
	pathXor    []int // XOR sum from node i to parent[i]
	rank       []int
	bases      []*LinearBasis
	history    []dsuChange // For rollback
}

type dsuChange struct {
	isUnion bool
	rootU, rootV int // roots involved in union
	oldParentV int
	oldPathXorV int
	oldRankU int
	oldBasisU *LinearBasis // Snapshot of basis[rootU] before merge
}

func NewDSU(n int) *DSU {
	parent := make([]int, n+1)
	pathXor := make([]int, n+1)
	rank := make([]int, n+1)
	bases := make([]*LinearBasis, n+1)
	for i := 0; i <= n; i++ {
		parent[i] = i
		bases[i] = &LinearBasis{}
	}
	return &DSU{
		parent:  parent,
		pathXor: pathXor,
		rank:    rank,
		bases:   bases,
		history: make([]dsuChange, 0),
	}
}

func (d *DSU) FindNoCompress(i int) (int, int) {
	currXor := 0
	for d.parent[i] != i {
		currXor ^= d.pathXor[i]
		i = d.parent[i]
	}
	return i, currXor
}

func (d *DSU) Union(u, v, w int) {
	rootU, xorU := d.FindNoCompress(u)
	rootV, xorV := d.FindNoCompress(v)

	if rootU == rootV {
		cycleXor := xorU ^ xorV ^ w
		d.history = append(d.history, dsuChange{isUnion: false, rootU: rootU, oldBasisU: d.bases[rootU].Copy()})
		d.bases[rootU].Insert(cycleXor)
		return
	}

	if d.rank[rootU] < d.rank[rootV] {
		rootU, rootV = rootV, rootU
		xorU, xorV = xorV, xorU
	}

	d.history = append(d.history, dsuChange{
		isUnion: true,
		rootU: rootU, rootV: rootV,
		oldParentV: d.parent[rootV],
		oldPathXorV: d.pathXor[rootV],
		oldRankU: d.rank[rootU],
		oldBasisU: d.bases[rootU].Copy(),
	})

	d.parent[rootV] = rootU
	d.pathXor[rootV] = xorU ^ w ^ xorV
	if d.rank[rootU] == d.rank[rootV] {
		d.rank[rootU]++
	}

	for i := MAX_XOR_BITS - 1; i >= 0; i-- {
		if d.bases[rootV].basis[i] != 0 {
			d.bases[rootU].Insert(d.bases[rootV].basis[i])
		}
	}
}

func (d *DSU) SaveState() int {
	return len(d.history)
}

func (d *DSU) Rollback(state int) {
	for len(d.history) > state {
		change := d.history[len(d.history)-1]
		d.history = d.history[:len(d.history)-1]

		d.bases[change.rootU] = change.oldBasisU

		if change.isUnion {
			d.parent[change.rootV] = change.oldParentV
			d.pathXor[change.rootV] = change.oldPathXorV
			d.rank[change.rootU] = change.oldRankU
		}
	}
}

type Edge struct {
	u, v, w int
}

type Query struct {
	s, t, x int
	id      int
}

var globalDSU *DSU
var allEdges []Edge
var finalAns []int

func minimizeTheMaximumEdgeWeight(n int, edges [][]int, queries [][]int) []int {
	globalDSU = NewDSU(n)

	allEdges = make([]Edge, len(edges))
	for i, e := range edges {
		allEdges[i] = Edge{e[0], e[1], e[2]}
	}
	sort.Slice(allEdges, func(i, j int) bool {
		return allEdges[i].w < allEdges[j].w
	})

	allQueries := make([]Query, len(queries))
	for i, q := range queries {
		allQueries[i] = Query{q[0], q[1], q[2], i}
	}

	finalAns = make([]int, len(queries))
	for i := range finalAns {
		finalAns[i] = -1 
	}

	solveRecursive(allQueries, 0, len(allEdges)-1, 0, 1_000_000_000)

	return finalAns
}

func solveRecursive(queries []Query, edgeL, edgeR int, lowW, highW int) {
	if len(queries) == 0 {
		return
	}
	if lowW == highW {
		for _, q := range queries {
			finalAns[q.id] = lowW
		}
		return
	}

	midW := lowW + (highW-lowW)/2

	dsuState := globalDSU.SaveState()

	currentEdgeIdx := edgeL
	for currentEdgeIdx <= edgeR && allEdges[currentEdgeIdx].w <= midW {
		e := allEdges[currentEdgeIdx]
		globalDSU.Union(e.u, e.v, e.w)
		currentEdgeIdx++
	}

	leftQueries := make([]Query, 0, len(queries))
	rightQueries := make([]Query, 0, len(queries))

	for _, q := range queries {
		rootS, xorS := globalDSU.FindNoCompress(q.s)
		rootT, xorT := globalDSU.FindNoCompress(q.t)

		if rootS != rootT {
			rightQueries = append(rightQueries, q)
		} else {
			pathXorST := xorS ^ xorT
			targetXor := q.x ^ pathXorST
			if globalDSU.bases[rootS].Query(targetXor) {
				leftQueries = append(leftQueries, q)
			} else {
				rightQueries = append(rightQueries, q)
			}
		}
	}

	solveRecursive(leftQueries, edgeL, currentEdgeIdx-1, lowW, midW)

	globalDSU.Rollback(dsuState)

	solveRecursive(rightQueries, currentEdgeIdx, edgeR, midW+1, highW)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}