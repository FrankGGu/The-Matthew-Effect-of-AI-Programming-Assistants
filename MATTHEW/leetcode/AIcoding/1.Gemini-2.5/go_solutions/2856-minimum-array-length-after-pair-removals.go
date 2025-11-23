import "sort"

func minLengthAfterRemovals(nums []int) int {
	n := len(nums)
	sort.Ints(nums)

	count := 0
	i := 0           // Pointer for the first half (potentially smaller elements)
	j := n / 2       // Pointer for the second half (potentially larger elements)

	for i < n/2 && j < n {
		if nums[i] < nums[j] {
			// Found a valid pair (nums[i], nums[j]) where nums[i] < nums[j]
			count++
			i++
			j++
		} else {
			// nums[i] is not strictly less than nums[j].
			// This means nums[j] is too small to be paired with current nums[i] (or any element before it).
			// We need to find a larger element for nums[i], so advance j.
			j++
		}
	}

	// The minimum length is the total length minus twice the number of pairs removed.
	return n - 2*count
}