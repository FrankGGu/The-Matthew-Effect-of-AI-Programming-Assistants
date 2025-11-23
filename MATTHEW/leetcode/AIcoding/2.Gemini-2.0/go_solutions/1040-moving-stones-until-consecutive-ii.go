import "sort"

func numMovesStonesII(stones []int) []int {
	sort.Ints(stones)
	n := len(stones)
	minMoves := n
	i := 0
	for j := 0; j < n; j++ {
		for stones[j]-stones[i]+1 > n {
			i++
		}
		if j-i+1 == n-1 && stones[j]-stones[i]+1 == n-1 {
			minMoves = min(minMoves, 2)
		} else {
			minMoves = min(minMoves, n-(j-i+1))
		}
	}

	maxMoves := max(stones[n-1]-stones[1]+1-n, stones[n-2]-stones[0]+1-n)

	return []int{minMoves, maxMoves}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}