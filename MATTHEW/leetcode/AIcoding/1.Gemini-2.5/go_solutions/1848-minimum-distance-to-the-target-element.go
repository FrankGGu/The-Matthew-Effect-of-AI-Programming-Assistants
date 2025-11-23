import "math"

func getMinDistance(nums []int, target int, start int) int {
	minDist := math.MaxInt32
	for i, num := range nums {
		if num == target {
			currentDist := i - start
			if currentDist < 0 {
				currentDist = -currentDist
			}
			if currentDist < minDist {
				minDist = currentDist
			}
		}
	}
	return minDist
}