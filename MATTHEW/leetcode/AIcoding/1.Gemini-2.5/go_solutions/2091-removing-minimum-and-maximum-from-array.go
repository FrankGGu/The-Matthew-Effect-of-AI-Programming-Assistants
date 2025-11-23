import "math"

func minimumDeletions(nums []int) int {
    n := len(nums)
    if n <= 2 {
        return n
    }

    minVal := nums[0]
    maxVal := nums[0]
    minIdx := 0
    maxIdx := 0

    for