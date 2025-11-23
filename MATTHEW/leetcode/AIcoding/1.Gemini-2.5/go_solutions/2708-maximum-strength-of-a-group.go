import "math"

func maxStrength(nums []int) int64 {
	n := len(nums)
	var maxProd int64 = math.MinInt64 // Initialize with the smallest possible int64 value

	// Iterate through all possible non-empty subsequences
	// Each bit in 'i' represents whether to