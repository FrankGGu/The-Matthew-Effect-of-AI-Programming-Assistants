func numOfWays(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 1
	}

	mod := int(1e9 + 7)
	C := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		C[i] = make([]int, n+1)
		C[i][0] = 1
		for j := 1; j <= i; j++ {
			C[i][j] = (C[i-1][j-1] + C[i-1][j]) % mod
		}
	}

	var solve func([]int) int
	solve = func(arr []int) int {
		m := len(arr)
		if m <= 1 {
			return 1
		}

		root := arr[0]
		left := []int{}
		right := []int{}
		for i := 1; i < m; i++ {
			if arr[i] < root {
				left = append(left, arr[i])
			} else {
				right = append(right, arr[i])
			}
		}

		leftWays := solve(left)
		rightWays := solve(right)
		return (C[m-1][len(left)] * leftWays % mod) * rightWays % mod
	}

	return (solve(nums) - 1 + mod) % mod
}