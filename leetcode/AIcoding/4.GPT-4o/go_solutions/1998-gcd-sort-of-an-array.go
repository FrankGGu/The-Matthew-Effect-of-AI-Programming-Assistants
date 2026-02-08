package main

import (
	"math"
	"sort"
)

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func gcdSort(nums []int) bool {
	n := len(nums)
	sorted := make([]int, n)
	copy(sorted, nums)
	sort.Ints(sorted)

	gcdMap := make([][]int, 100001)
	for _, num := range nums {
		gcdMap[num] = append(gcdMap[num], num)
	}

	visited := make([]bool, 100001)
	for i := 0; i < n; i++ {
		if visited[nums[i]] {
			continue
		}
		stack := []int{nums[i]}
		visited[nums[i]] = true
		component := []int{}

		for len(stack) > 0 {
			current := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			component = append(component, current)

			for j := 1; j <= 100000; j++ {
				if current*j > 100000 {
					break
				}
				if len(gcdMap[j]) > 0 && gcd(current, j) == j {
					for _, neighbor := range gcdMap[j] {
						if !visited[neighbor] {
							visited[neighbor] = true
							stack = append(stack, neighbor)
						}
					}
					gcdMap[j] = nil
				}
			}
		}

		sort.Ints(component)
		for j := 0; j < len(component); j++ {
			if component[j] != sorted[i+j] {
				return false
			}
		}
	}

	return true
}