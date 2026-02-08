package main

import "container/list"

func minimumTime(n int, durations []int, relations [][]int) int {
	adj := make([][]int, n+1)
	inDegree := make([]int, n+1)
	dp := make([]int, n+1) // dp[i] stores the minimum time to complete course i and all its prerequisites

	for i := 1; i <= n; i++ {
		dp[i] = durations[i-1]
	}

	for _, relation := range relations {
		prevCourse := relation[0]
		nextCourse := relation[1]
		adj[prevCourse] = append(adj[prevCourse], nextCourse)
		inDegree[nextCourse]++
	}

	queue := list.New()
	for i := 1; i <= n; i++ {
		if inDegree[i] == 0 {
			queue.PushBack(i)
		}
	}

	for queue.Len() > 0 {
		u := queue.Remove(queue.Front()).(int)

		for _, v := range adj[u] {
			if dp[u]+durations[v-1] > dp[v] {
				dp[v] = dp[u] + durations[v-1]
			}

			inDegree[v]--
			if inDegree[v] == 0 {
				queue.PushBack(v)
			}
		}
	}

	maxTime := 0
	for i := 1; i <= n; i++ {
		if dp[i] > maxTime {
			maxTime = dp[i]
		}
	}

	return maxTime
}