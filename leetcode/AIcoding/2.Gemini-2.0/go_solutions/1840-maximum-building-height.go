import (
	"math"
	"sort"
)

func maxBuilding(n int, restrictions [][]int) int {
	restrictions = append(restrictions, []int{1, 0})
	restrictions = append(restrictions, []int{n, n - 1})
	sort.Slice(restrictions, func(i, j int) bool {
		return restrictions[i][0] < restrictions[j][0]
	})

	for i := 1; i < len(restrictions); i++ {
		restrictions[i][1] = min(restrictions[i][1], restrictions[i-1][1]+restrictions[i][0]-restrictions[i-1][0])
	}

	for i := len(restrictions) - 2; i >= 0; i-- {
		restrictions[i][1] = min(restrictions[i][1], restrictions[i+1][1]+restrictions[i+1][0]-restrictions[i][0])
	}

	ans := 0
	for i := 1; i < len(restrictions); i++ {
		a := restrictions[i-1][0]
		b := restrictions[i-1][1]
		c := restrictions[i][0]
		d := restrictions[i][1]
		diff := abs(b - d)
		dist := c - a
		if diff >= dist {
			ans = max(ans, max(b, d))
		} else {
			h := (dist - diff) / 2
			ans = max(ans, max(b, d)+h)
		}
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
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

func main() {}