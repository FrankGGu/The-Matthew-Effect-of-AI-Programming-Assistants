package main

func maxJumps(arr []int, d int) int {
	n := len(arr)
	memo := make([]int, n)

	var dfs func(i int) int
	dfs = func(i int) int {
		if memo[i] != 0 {
			return memo[i]
		}

		res := 1

		// Jump to the right
		for k := 1; k <= d; k++ {
			j := i + k
			if j >= n {
				break
			}
			if arr[j] >= arr[i] {
				break
			}
			res = max(res, 1+dfs(j))
		}

		// Jump to the left
		for k := 1; k <= d; k++ {
			j := i - k
			if j < 0 {
				break
			}
			if arr[j] >= arr[i] {
				break
			}
			res = max(res, 1+dfs(j))
		}

		memo[i] = res
		return res
	}

	maxRes := 0
	for i := 0; i < n; i++ {
		maxRes = max(maxRes, dfs(i))
	}

	return maxRes
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}