package main

import "fmt"

func maxOperations(nums []int) int {
	n := len(nums)
	if n < 2 {
		return 0
	}

	// Helper function for memoized recursion
	// memo: map[int]int where key is left*1001 + right, value is max operations
	// We use 1001 because max n is 1000, so max right index is 999.
	// left*1001 + right ensures unique key for (left, right) pairs.
	var dfs func(left, right, target int, memo map[int]int) int
	dfs = func(left, right, target int, memo map[int]int) int {
		if left >= right {
			return 0
		}

		key := left*1001 + right
		if val, ok := memo[key]; ok {
			return val
		}

		res := 0
		// Option 1: remove nums[left] and nums[left+1]
		if left+1 <= right && nums[left]+nums[left+1] == target {
			res = max(res, 1+dfs(left+2, right, target, memo))
		}

		// Option 2: remove nums[left] and nums[right]
		if nums[left]+nums[right] == target {
			res = max(res, 1+dfs(left+1, right-1, target, memo))
		}

		// Option 3: remove nums[right-1] and nums[right]
		if right-1 >= left && nums[right-1]+nums[right] == target {
			res = max(res, 1+dfs(left, right-2, target, memo))
		}

		memo[key] = res
		return res
	}

	ans := 0

	// Case 1: Initial operation removes nums[0] and nums[1]
	// Remaining subarray: nums[2...n-1]
	target1 := nums[0] + nums[1]
	memo1 := make(map[int]int)
	ans = max(ans, 1+dfs(2, n-1, target1, memo1))

	// Case 2: Initial operation removes nums[0] and nums[n-1]
	// Remaining subarray: nums[1...n-2]
	target2 := nums[0] + nums[n-1]
	memo2 := make(map[int]int)
	ans = max(ans, 1+dfs(1, n-2, target2, memo2))

	// Case 3: Initial operation removes nums[n-2] and nums[n-1]
	// Remaining subarray: nums[0...n-3]
	target3 := nums[n-2] + nums[n-1]
	memo3 := make(map[int]int)
	ans = max(ans, 1+dfs(0, n-3, target3, memo3))

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}