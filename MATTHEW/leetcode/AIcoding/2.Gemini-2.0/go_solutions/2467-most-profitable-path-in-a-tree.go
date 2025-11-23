import "math"

func mostProfitablePath(edges [][]int, bob int, amount []int) int {
	n := len(amount)
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	bobPath := make([]int, 0)
	bobFound := false
	var dfsBob func(node, parent int) bool
	dfsBob = func(node, parent int) bool {
		bobPath = append(bobPath, node)
		if node == 0 {
			bobFound = true
			return true
		}
		for _, neighbor := range graph[node] {
			if neighbor != parent {
				if dfsBob(neighbor, node) {
					return true
				}
			}
		}
		bobPath = bobPath[:len(bobPath)-1]
		return false
	}

	dfsBob(bob, -1)

	bobDist := make([]int, n)
	for i := range bobDist {
		bobDist[i] = -1
	}

	for i, node := range bobPath {
		bobDist[node] = i
	}

	aliceProfit := make([]int, n)
	var dfsAlice func(node, parent, dist int)
	dfsAlice = func(node, parent, dist int) {
		if bobDist[node] == -1 || dist < bobDist[node] {
			aliceProfit[node] = amount[node]
		} else if dist == bobDist[node] {
			aliceProfit[node] = amount[node] / 2
		}

		for _, neighbor := range graph[node] {
			if neighbor != parent {
				dfsAlice(neighbor, node, dist+1)
			}
		}
	}

	dfsAlice(0, -1, 0)

	maxProfit := math.MinInt32
	var dfsMaxProfit func(node, parent, currentProfit int)
	dfsMaxProfit = func(node, parent, currentProfit int) {
		isLeaf := true
		for _, neighbor := range graph[node] {
			if neighbor != parent {
				isLeaf = false
				dfsMaxProfit(neighbor, node, currentProfit+aliceProfit[neighbor])
			}
		}
		if isLeaf {
			maxProfit = max(maxProfit, currentProfit)
		}
	}

	dfsMaxProfit(0, -1, amount[0])

	return maxProfit
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}