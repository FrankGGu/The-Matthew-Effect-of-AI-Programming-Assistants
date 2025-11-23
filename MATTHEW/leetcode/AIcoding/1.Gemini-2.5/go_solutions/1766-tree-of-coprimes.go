package main

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

var adj [][]int
var numsGlobal []int
var ans []int
var ancestorPathInfo [51]struct{ depth, nodeIdx int }

func dfs(u, p, depth int) {
	currentVal := numsGlobal[u]

	bestDepth := -1
	bestNodeIdx := -1

	for v := 1; v <= 50; v++ {
		if gcd(currentVal, v) == 1 {
			ancDepth := ancestorPathInfo[v].depth
			ancNodeIdx := ancestorPathInfo[v].nodeIdx

			if ancDepth != -1 {
				if ancDepth > bestDepth {
					bestDepth = ancDepth
					bestNodeIdx = ancNodeIdx
				} else if ancDepth == bestDepth {
					if ancNodeIdx < bestNodeIdx {
						bestNodeIdx = ancNodeIdx
					}
				}
			}
		}
	}
	ans[u] = bestNodeIdx

	oldAncestorInfoForCurrentVal := ancestorPathInfo[currentVal]
	ancestorPathInfo[currentVal] = struct{ depth, nodeIdx int }{depth, u}

	for _, v := range adj[u] {
		if v != p {
			dfs(v, u, depth+1)
		}
	}

	ancestorPathInfo[currentVal] = oldAncestorInfoForCurrentVal
}

func getCoprimes(nums []int, edges [][]int) []int {
	n := len(nums)
	numsGlobal = nums

	adj = make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	ans = make([]int, n)

	for i := 0; i <= 50; i++ {
		ancestorPathInfo[i] = struct{ depth, nodeIdx int }{-1, -1}
	}

	dfs(0, -1, 0)

	return ans
}