import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func getMinDistance(nums []int, target int, start int) int {
	minDist := math.MaxInt32
	for i := 0; i < len(nums); i++ {
		if nums[i] == target {
			minDist = min(minDist, abs(i-start))
		}
	}
	return minDist
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {}