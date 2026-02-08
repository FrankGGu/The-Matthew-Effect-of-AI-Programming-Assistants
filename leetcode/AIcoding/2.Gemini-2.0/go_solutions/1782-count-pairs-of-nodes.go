func countPairs(n int, edges [][]int, queries []int) []int {
	degree := make([]int, n+1)
	sameEdges := make(map[int]int)
	adj := make([][]int, n+1)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		degree[u]++
		degree[v]++
		if u > v {
			u, v = v, u
		}
		sameEdges[u*100000+v]++
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	sortedDegree := make([]int, n+1)
	copy(sortedDegree, degree)
	sortedDegree = sortedDegree[1:]
	sort.Ints(sortedDegree)

	ans := make([]int, len(queries))
	for i, query := range queries {
		count := 0
		for x := 1; x <= n; x++ {
			l, r := 0, n-1
			res := -1
			for l <= r {
				mid := l + (r-l)/2
				if sortedDegree[mid] > query-degree[x] {
					res = mid
					r = mid - 1
				} else {
					l = mid + 1
				}
			}
			if res == -1 {
				continue
			}
			count += n - res

			if degree[x]*2 > query {
				if degree[x] <= sortedDegree[n-degree[x]] {
					count--
				}
			}
		}
		ans[i] = count / 2

		for x := 1; x <= n; x++ {
			for _, y := range adj[x] {
				if x >= y {
					continue
				}
				if degree[x]+degree[y] > query && degree[x]+degree[y]-sameEdges[x*100000+y] <= query {
					ans[i]--
				}
			}
		}

	}

	return ans
}

import "sort"