package main

import "sort"

func smallestArrayWithSwaps(nums []int, pairs [][]int) []int {
	n := len(nums)
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}

	find := func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		parent[find(x)] = find(y)
	}

	for _, pair := range pairs {
		union(pair[0], pair[1])
	}

	groupMap := make(map[int][]int)
	for i := 0; i < n; i++ {
		root := find(i)
		groupMap[root] = append(groupMap[root], nums[i])
	}

	for _, group := range groupMap {
		sort.Ints(group)
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		root := find(i)
		result[i] = groupMap[root][0]
		groupMap[root] = groupMap[root][1:]
	}

	return result
}