import (
	"sort"
)

func findRadius(houses []int, heaters []int) int {
	sort.Ints(houses)
	sort.Ints(heaters)
	res := 0
	i := 0
	for _, house := range houses {
		for i < len(heaters)-1 && abs(heaters[i]-house) >= abs(heaters[i+1]-house) {
			i++
		}
		if abs(heaters[i]-house) > res {
			res = abs(heaters[i] - house)
		}
	}
	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}