import (
	"sort"
)

func maximizeSquareHoleArea(n int, m int, hBars []int, vBars []int) int {
	sort.Ints(hBars)
	sort.Ints(vBars)

	maxHoleH := 1
	currHoleH := 1
	for i := 1; i < len(hBars); i++ {
		if hBars[i] == hBars[i-1]+1 {
			currHoleH++
		} else {
			if currHoleH > maxHoleH {
				maxHoleH = currHoleH
			}
			currHoleH = 1
		}
	}
	if currHoleH > maxHoleH {
		maxHoleH = currHoleH
	}

	maxHoleV := 1
	currHoleV := 1
	for i := 1; i < len(vBars); i++ {
		if vBars[i] == vBars[i-1]+1 {
			currHoleV++
		} else {
			if currHoleV > maxHoleV {
				maxHoleV = currHoleV
			}
			currHoleV = 1
		}
	}
	if currHoleV > maxHoleV {
		maxHoleV = currHoleV
	}

	side := min(maxHoleH+1, maxHoleV+1)
	return side * side
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}