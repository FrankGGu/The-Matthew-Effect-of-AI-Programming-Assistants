package main

import (
	"sort"
)

type UnionFind struct {
	parent []int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &UnionFind{parent: parent}
}

func (uf *UnionFind) Find(i int) int {
	if uf.parent[i] == i {
		return i
	}
	uf.parent[i] = uf.Find(uf.parent[i])
	return uf.parent[i]
}

func (uf *UnionFind) Union(i, j int) {
	rootI := uf.Find(i)
	rootJ := uf.Find(j)
	if rootI != rootJ {
		uf.parent[rootJ] = rootI
	}
}

func (uf *UnionFind) Reset(i int) {
	uf.parent[i] = i
}

func findAllPeople(n int, meetings [][]int, firstPerson int) []int {
	sort.Slice(meetings, func(i, j int) bool {
		return meetings[i][2] < meetings[j][2]
	})

	knownSecret := make([]bool, n)
	knownSecret[0] = true
	knownSecret[firstPerson] = true

	uf := NewUnionFind(n)

	i := 0
	for i < len(meetings) {
		currentTime := meetings[i][2]

		uniquePeopleInCurrentTimeSlice := make(map[int]struct{})

		j := i
		for j < len(meetings) && meetings[j][2] == currentTime {
			p1, p2 := meetings[j][0], meetings[j][1]

			uf.Union(p1, p2)

			uniquePeopleInCurrentTimeSlice[p1] = struct{}{}
			uniquePeopleInCurrentTimeSlice[p2] = struct{}{}
			j++
		}

		componentKnowsSecret := make(map[int]bool)

		for p := range uniquePeopleInCurrentTimeSlice {
			rootP := uf.Find(p)
			if knownSecret[p] {
				componentKnowsSecret[rootP] = true
			}
		}

		for p := range uniquePeopleInCurrentTimeSlice {
			rootP := uf.Find(p)
			if componentKnowsSecret[rootP] {
				knownSecret[p] = true
			} else {
				uf.Reset(p)
			}
		}

		i = j
	}

	result := make([]int, 0)
	for k := 0; k < n; k++ {
		if knownSecret[k] {
			result = append(result, k)
		}
	}

	return result
}