import "sort"

func findRadius(houses []int, heaters []int) int {
	sort.Ints(houses)
	sort.Ints(heaters)

	maxRadius := 0
	for _, house := range houses {
		radius := findNearestHeater(house, heaters)
		if radius > maxRadius {
			maxRadius = radius
		}
	}

	return maxRadius
}

func findNearestHeater(house int, heaters []int) int {
	low := 0
	high := len(heaters) - 1
	minRadius := -1

	for low <= high {
		mid := low + (high-low)/2
		radius := abs(heaters[mid] - house)

		if minRadius == -1 || radius < minRadius {
			minRadius = radius
		}

		if heaters[mid] < house {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	if high >= 0 {
		radius := abs(heaters[high] - house)
		if radius < minRadius {
			minRadius = radius
		}
	}

	if low < len(heaters) {
		radius := abs(heaters[low] - house)
		if radius < minRadius {
			minRadius = radius
		}
	}

	return minRadius
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}