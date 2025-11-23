import "math"

func maxValueAfterReverse(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	initialSum := 0
	for i := 0; i < n-1; i++ {
		initialSum += int(math.Abs(float