import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minMovesToMakeZigzag(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0