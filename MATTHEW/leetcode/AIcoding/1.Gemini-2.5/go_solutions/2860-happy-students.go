import (
	"sort"
)

func countWays(nums []int) int {
	sort.Ints(nums)
	n := len(nums)

	ans := 0

	// Case 1: 0 students selected.
	// All students are unselected.
	// For each unselected student j, the number of selected students (0) must be <= nums[j].
	// Since nums[j] >= 0, 0 <= nums[j] is always true.
	// So, k=0 is always a valid way.
	ans++

	// Case 2: k students selected, where 1 <= k < n.
	// To maximize the chance of satisfying conditions, we select the k students with the smallest nums[i] values.
	// These are nums[0], ..., nums[k-1].
	// The remaining n-k students, nums[k], ..., nums[n-1], are unselected.
	for k := 1; k < n; k++ {
		// Condition for selected students (nums[0]...nums[k-1]):
		// The count of selected students (k) must be strictly greater than nums[i] for all i from 0 to k-1.
		// Since nums is sorted, this is equivalent to k > nums[k-1].

		// Condition for unselected students (nums[k]...nums[n-1]):
		// The count of selected students (k) must be less than or equal to nums[j] for all j from k to n-1.
		// Since nums is sorted, this is equivalent to k <= nums[k].

		if k > nums[k-1] && k <= nums[k] {
			ans++
		}
	}

	// Case 3: n students selected.
	// All students are selected (nums[0]...nums[n-1]).
	// No students are unselected.
	// Condition for selected students:
	// The count of selected students (n) must be strictly greater than nums[i] for all i from 0 to n-1.
	// Since nums is sorted, this is equivalent to n > nums[n-1].
	if n > nums[n-1] {
		ans++
	}

	return ans
}