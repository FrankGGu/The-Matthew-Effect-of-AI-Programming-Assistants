package main

import (
	"math"
)

func largestComponentSize(A []int) int {
	n := len(A)
	maxNum := 0
	for _, num := range A {
		if num > maxNum {
			maxNum = num
		}
	}
	parent := make([]int, maxNum+1)
	for i := range parent {
		parent[i] = i
	}
	find := func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}
	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
		}
	}

	for _, num := range A {
		for i := 2; i <= int(math.Sqrt(float64(num))); i++ {
			if num%i == 0 {
				union(num, i)
				union(num, num/i)
			}
		}
	}

	counter := make(map[int]int)
	for _, num := range A {
		counter[find(num)]++
	}

	maxSize := 0
	for _, size := range counter {
		if size > maxSize {
			maxSize = size
		}
	}
	return maxSize
}