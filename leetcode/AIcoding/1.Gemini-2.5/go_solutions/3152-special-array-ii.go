package main

import (
	"math"
	"sort"
)

type Query struct {
	l, r, idx int
}

type MoSorter struct {
	queries   []Query
	blockSize int
}

func (s MoSorter) Len() int { return len(s.queries) }
func (s MoSorter) Swap(i, j int) { s.queries[i], s.queries[j] = s.queries[j], s.queries[i] }
func (s MoSorter) Less(i, j int) bool {
	blockA := s.queries[i].l / s.blockSize
	blockB := s.queries[j].l / s.blockSize
	if blockA != blockB {
		return blockA < blockB
	}
	if blockA%2 == 0 {
		return s.queries[i].r < s.queries[j].r
	}
	return s.queries[i].r > s.queries[j].r
}

func specialArrayII(nums []int, queries [][]int) []int64 {
	n := len(nums)
	qLen := len(queries)

	if n == 0 {
		return make([]int64, qLen)
	}

	uniqueVals := make(map[int]struct{})
	for _, x := range nums {
		uniqueVals[x] = struct{}{}
	}
	sortedUnique := make([]int, 0, len(uniqueVals))
	for x := range uniqueVals {
		sortedUnique = append(sortedUnique, x)
	}
	sort.Ints(sortedUnique)

	valToID := make(map[int]int)
	for i, val := range sortedUnique {
		valToID[val] = i
	}

	numsCompressed := make([]int, n)
	for i, x := range nums {
		numsCompressed[i] = valToID[x]
	}

	freq := make([]int, len(sortedUnique))
	currentAns := int64(0)

	add := func(idx int) {
		val := numsCompressed[idx]
		currentAns -= int64(freq[val]) * int64(freq[val]+1) / 2
		freq[val]++
		currentAns += int64(freq[val]) * int64(freq[val]+1) / 2
	}

	remove := func(idx int) {
		val := numsCompressed[idx]
		currentAns -= int64(freq[val]) * int64(freq[val]+1) / 2
		freq[val]--
		currentAns += int64(freq[val]) * int64(freq[val]+1) / 2
	}

	queryStructs := make([]Query, qLen)
	for i := 0; i < qLen; i++ {
		queryStructs[i] = Query{l: queries[i][0], r: queries[i][1], idx: i}
	}

	localBlockSize := int(math.Sqrt(float64(n)))
	if localBlockSize == 0 {
		localBlockSize = 1
	}

	sorter := MoSorter{queries: queryStructs, blockSize: localBlockSize}
	sort.Sort(sorter)
	queryStructs = sorter.queries

	ans := make([]int64, qLen)
	currentL, currentR := 0, -1

	for _, q := range queryStructs {
		l, r, idx := q.l, q.r, q.idx

		for currentR < r {
			currentR++
			add(currentR)
		}
		for currentL > l {
			currentL--
			add(currentL)
		}
		for currentR > r {
			remove(currentR)
			currentR--
		}
		for currentL < l {
			remove(currentL)
			currentL++
		}
		ans[idx] = currentAns
	}

	return ans
}