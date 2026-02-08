package main

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func isSameComponent(parent []int, x, y int) bool {
	return find(parent, x) == find(parent, y)
}

func find(parent []int, x int) int {
	if parent[x] != x {
		parent[x] = find(parent, parent[x])
	}
	return parent[x]
}

func union(parent []int, x, y int) {
	pX := find(parent, x)
	pY := find(parent, y)
	if pX != pY {
		parent[pY] = pX
	}
}

func gcdSortArray(nums []int) bool {
	maxNum := 0
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}

	parent := make([]int, maxNum+1)
	for i := 0; i <= maxNum; i++ {
		parent[i] = i
	}

	for i := 2; i <= maxNum; i++ {
		for j := 2; i*j <= maxNum; j++ {
			union(parent, i, i*j)
		}
	}

	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			if gcd(nums[i], nums[j]) > 1 && !isSameComponent(parent, nums[i], nums[j]) {
				return false
			}
		}
	}

	return true
}