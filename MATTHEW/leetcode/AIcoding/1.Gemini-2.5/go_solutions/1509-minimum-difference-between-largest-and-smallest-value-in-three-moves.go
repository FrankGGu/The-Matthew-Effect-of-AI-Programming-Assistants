import (
	"math"
	"sort"
)

func minDifference(nums []int) int {
	n := len(nums)
	if n <= 4 {
		return 0
	}

	sort.Ints(nums)

	// We can change up to 3 elements. This means we can effectively remove 3 elements
	// from either end of the sorted array.
	// We need to consider 4 scenarios for the remaining n-3 elements:
	// 1. Remove 3 largest elements: remaining are nums[0...n-4]
	//    Difference: nums[n-4] - nums[0]
	// 2. Remove 2 largest elements and 1 smallest element: remaining are nums[1...n-3]
	//    Difference: nums[n-3] - nums[1]
	// 3. Remove 1 largest element and 2 smallest elements: remaining are nums[2...n-2]
	//    Difference: nums[n-2] - nums[2]
	// 4. Remove 3 smallest elements: remaining are nums[3...n-1]
	//    Difference: nums[n-1] - nums[3]

	minDiff := math.MaxInt32

	// Scenario 1: Remove 3 largest
	minDiff = int(math.Min(float64(minDiff), float64(nums[n-4]-nums[0])))

	// Scenario 2: Remove 2 largest, 1 smallest
	minDiff = int(math.Min(float64(minDiff), float64(nums[n-3]-nums[1])))

	// Scenario 3: Remove 1 largest, 2 smallest
	minDiff = int(math.Min(float64(minDiff), float64(nums[n-2]-nums[2])))

	// Scenario 4: Remove 3 smallest
	minDiff = int(math.Min(float64(minDiff), float64(nums[n-1]-nums[3])))

	return minDiff
}