func rootCount(edges [][]int, guesses [][]int, k int) int {
	n := len(edges) + 1
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	guessMap := make(map[int]map[int]bool)
	for _, guess := range guesses {
		if _, ok := guessMap[guess[0]]; !ok {
			guessMap[guess[0]] = make(map[int]bool)
		}
		guessMap[guess[0]][guess[1]] = true
	}

	var dfs func(node, parent int) int
	dfs = func(node, parent int) int {
		count := 0
		if _, ok := guessMap[node]; ok {
			if _, ok2 := guessMap[node][parent]; ok2 {
				count++
			}
		}
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				if _, ok := guessMap[parent]; ok {
					if _, ok2 := guessMap[parent][node]; ok2 {
						count--
					}
				}
				count += dfs(neighbor, node)
			}
		}
		return count
	}

	correctGuesses := 0
	var dfs2 func(node, parent int) int
	dfs2 = func(node, parent int) int {
		count := 0
		if _, ok := guessMap[node]; ok {
			if _, ok2 := guessMap[node][parent]; ok2 {
				count++
			}
		}
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				if _, ok := guessMap[node]; ok {
					if _, ok2 := guessMap[node][neighbor]; ok2 {
						count++
					}
				}
				count += dfs2(neighbor, node)
			}
		}
		return count
	}

	initialCorrectGuesses := dfs2(0, -1)
	result := 0
	if initialCorrectGuesses >= k {
		result++
	}

	var reroot func(node, parent int, correctGuesses int)
	reroot = func(node, parent int, correctGuesses int) {
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				newCorrectGuesses := correctGuesses
				if _, ok := guessMap[node]; ok {
					if _, ok2 := guessMap[node][neighbor]; ok2 {
						newCorrectGuesses--
					}
				}
				if _, ok := guessMap[neighbor]; ok {
					if _, ok2 := guessMap[neighbor][node]; ok2 {
						newCorrectGuesses++
					}
				}

				if newCorrectGuesses >= k {
					result++
				}
				reroot(neighbor, node, newCorrectGuesses)
			}
		}
	}

	reroot(0, -1, initialCorrectGuesses)

	return result
}