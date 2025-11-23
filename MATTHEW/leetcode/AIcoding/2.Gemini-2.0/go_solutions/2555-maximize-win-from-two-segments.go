import (
	"sort"
)

func maximizeWin(prizePositions []int, k int) int {
	sort.Ints(prizePositions)
	n := len(prizePositions)
	maxWins := 0
	for i := 0; i < n; i++ {
		j := sort.SearchInts(prizePositions, prizePositions[i]+k+1)
		firstWin := j - i

		secondWin := 0
		for l := j; l < n; l++ {
			m := sort.SearchInts(prizePositions, prizePositions[l]+k+1)
			secondWin = max(secondWin, m-l)
		}

		maxWins = max(maxWins, firstWin+secondWin)
	}
	return maxWins
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}