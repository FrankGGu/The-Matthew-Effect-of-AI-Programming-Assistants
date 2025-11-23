package main

func lexicalOrder(n int) []int {
	result := make([]int, 0, n)
	var dfs func(int)
	dfs = func(k int) {
		if k > n {
			return
		}
		result = append(result, k)
		for i := 0; i < 10; i++ {
			dfs(k*10 + i)
		}
	}
	dfs(1)
	return result
}