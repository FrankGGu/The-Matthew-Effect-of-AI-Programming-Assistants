import (
	"sort"
)

func finalArrayState(nums []int, k int) []int {
	n := len(nums)

	// Sort nums in ascending order.
	// This is crucial because to maximize the sum, additional multiplications
	// (beyond the base distribution) should be applied to the largest elements.
	sort.Ints(nums)

	// Calculate the base number of times each element will be multiplied by 2.
	// This is floor(k / n).
	basePower := k / n

	// Calculate the number of remaining multiplications to be distributed
	// among the largest elements. This is k % n.
	remainderCount := k % n

	result := make([]int, n)

	// Iterate through the sorted array to apply multiplications.
	// The first (n - remainderCount) elements will be multiplied by 2^basePower.
	// The last remainderCount elements (which are the largest in the sorted array)
	// will be multiplied by 2^(basePower + 1).
	for i := 0; i < n; i++ {
		if i < n-remainderCount {
			// Smaller elements get basePower multiplications
			result[i] = nums[i] * (1 << basePower)
		} else {
			// Larger elements get basePower + 1 multiplications
			result[i] = nums[i] * (1 << (basePower + 1))
		}
	}

	return result
}