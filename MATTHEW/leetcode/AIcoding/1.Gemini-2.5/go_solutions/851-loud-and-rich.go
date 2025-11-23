package main

func loudAndRich(richer [][]int, quiet []int) []int {
	n := len(quiet)

	adj := make([][]int, n)
	for _, r := range richer {
		richerPerson := r[0]
		poorerPerson := r[1]
		adj[poorerPerson] = append(adj[poorerPerson], richerPerson)
	}

	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}

	var dfs func(u int) int
	dfs = func(u int) int {
		if ans[u] != -1 {
			return ans[u]
		}

		currentMinQuietPersonIdx := u

		for _, v := range adj[u] {
			richerQuietestIdx := dfs(v)
			if quiet[richerQuietestIdx] < quiet[currentMinQuietPersonIdx] {
				currentMinQuietPersonIdx = richerQuietestIdx
			}
		}

		ans[u] = currentMinQuietPersonIdx
		return currentMinQuietPersonIdx
	}

	for i := 0; i < n; i++ {
		dfs(i)
	}

	return ans
}