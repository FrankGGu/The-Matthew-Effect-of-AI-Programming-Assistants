package main

import (
	"sort"
)

type FenwickTree struct {
	bit  []int
	size int
}

func newFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		bit:  make([]int, size+1),
		size: size,
	}
}

func (ft *FenwickTree) update(idx, delta int) {
	for idx <= ft.size {
		ft.bit[idx] += delta
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) query(idx int) int {
	sum := 0
	for idx > 0 {
		sum += ft.bit[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func distributeElements(nums []int) []int {
	n := len(nums)

	uniqueValsMap := make(map[int]bool)
	for _, x := range nums {
		uniqueValsMap[x] = true
	}

	sortedUnique := make([]int, 0, len(uniqueValsMap))
	for x := range uniqueValsMap {
		sortedUnique = append(sortedUnique, x)
	}
	sort.Ints(sortedUnique)

	valToRank := make(map[int]int)
	for i, x := range sortedUnique {
		valToRank[x] = i + 1
	}
	maxRank := len(sortedUnique)

	arr1 := []int{nums[0]}
	arr2 := []int{nums[1]}

	ft1 := newFenwickTree(maxRank)
	ft2 := newFenwickTree(maxRank)

	ft1.update(valToRank[nums[0]], 1)
	ft2.update(valToRank[nums[1]], 1)

	for i := 2; i < n; i++ {
		currVal := nums[i]
		currRank := valToRank[currVal]

		count1 := ft1.query(maxRank) - ft1.query(currRank)
		count2 := ft2.query(maxRank) - ft2.query(currRank)

		if count1 > count2 {
			arr1 = append(arr1, currVal)
			ft1.update(currRank, 1)
		} else if count2 > count1 {
			arr2 = append(arr2, currVal)
			ft2.update(currRank, 1)
		} else {
			if len(arr1) <= len(arr2) {
				arr1 = append(arr1, currVal)
				ft1.update(currRank, 1)
			} else {
				arr2 = append(arr2, currVal)
				ft2.update(currRank, 1)
			}
		}
	}

	return append(arr1, arr2...)
}