import (
	"math"
	"sort"
)

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func repairCars(ranks []int, cars int) int64 {
	sort.Ints(ranks)
	left := int64(0)
	right := int64(ranks[0]) * int64(cars) * int64(cars)

	var check = func(mid int64) bool {
		total := int64(0)
		for _, r := range ranks {
			total += int64(math.Sqrt(float64(mid / int64(r))))
			if total >= int64(cars) {
				return true
			}
		}
		return total >= int64(cars)
	}

	for left < right {
		mid := left + (right-left)/2
		if check(mid) {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return left
}