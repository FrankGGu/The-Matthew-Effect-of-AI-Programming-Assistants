import "sort"

func distributeCandies(candyType []int) int {
	uniqueCandies := make(map[int]struct{})
	for _, candy := range candyType {
		uniqueCandies[candy] = struct{}{}
	}

	numUniqueTypes := len(uniqueCandies)
	maxCandiesToEat := len(candyType) / 2

	if numUniqueTypes < maxCandiesToEat {
		return numUniqueTypes
	}
	return maxCandiesToEat
}