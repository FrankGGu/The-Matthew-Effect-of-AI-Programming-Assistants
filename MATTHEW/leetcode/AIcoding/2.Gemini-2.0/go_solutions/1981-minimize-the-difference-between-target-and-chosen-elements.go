import (
	"math"
)

func minimizeTheDifference(mat [][]int, target int) int {
	m := len(mat)
	possibleSums := map[int]bool{0: true}

	for i := 0; i < m; i++ {
		newPossibleSums := make(map[int]bool)
		for sum := range possibleSums {
			for _, num := range mat[i] {
				newPossibleSums[sum+num] = true
			}
		}
		possibleSums = newPossibleSums
	}

	minDiff := math.MaxInt32
	for sum := range possibleSums {
		diff := int(math.Abs(float64(sum - target)))
		if diff < minDiff {
			minDiff = diff
		}
	}

	return minDiff
}