import "math"

func increasingTriplet(nums []int) bool {
	first := math.MaxInt32
	second := math.MaxInt32

	for _, num := range nums {
		if num <= first {
			first = num
		} else if num <= second { // num > first && num <= second