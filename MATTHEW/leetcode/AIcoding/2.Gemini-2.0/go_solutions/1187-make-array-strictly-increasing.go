import (
	"math"
	"sort"
)

func makeArrayIncreasing(arr1 []int, arr2 []int) int {
	sort.Ints(arr2)
	dp := map[int]int{-1: 0}

	for _, num := range arr1 {
		newDp := map[int]int{}
		for prev, steps := range dp {
			if num > prev {
				if _, ok := newDp[num]; !ok || newDp[num] > steps {
					newDp[num] = steps
				}
			}

			idx := sort.SearchInts(arr2, prev+1)
			if idx < len(arr2) {
				replacement := arr2[idx]
				if _, ok := newDp[replacement]; !ok || newDp[replacement] > steps+1 {
					newDp[replacement] = steps + 1
				}
			}
		}
		if len(newDp) == 0 {
			return -1
		}
		dp = newDp
	}

	minSteps := math.MaxInt32
	for _, steps := range dp {
		if steps < minSteps {
			minSteps = steps
		}
	}

	return minSteps
}