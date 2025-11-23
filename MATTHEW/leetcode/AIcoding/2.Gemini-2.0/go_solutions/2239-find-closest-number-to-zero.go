import "math"

func findClosestNumber(nums []int) int {
	closest := nums[0]
	for _, num := range nums {
		if math.Abs(float64(num)) < math.Abs(float64(closest)) {
			closest = num
		} else if math.Abs(float64(num)) == math.Abs(float64(closest)) && num > closest {
			closest = num
		}
	}
	return closest
}