func findLatestStep(arr []int, m int) int {
	n := len(arr)

	// group_len[i] stores the length of the group that starts at index i,
	// and also the length of the group that ends at index i.
	// We use n+2 size for padding at both ends (index 0 and n+1).
	group_len := make([]int, n+2)

	// num_m_groups counts how many contiguous subarrays of ones of length m exist.
	num_m_groups := 0

	ans := -1

	for i := 0; i < n; i++ {
		pos := arr[i] // The 1-indexed position to set to 1

		// Get lengths of adjacent groups
		leftLen := group_len[pos-1]
		rightLen := group_len[pos+1]

		// If merging existing groups, they are destroyed.
		// Decrement num_m_groups for the groups they contained.
		if leftLen >= m {
			num_m_groups -= (leftLen - m + 1)
		}
		if rightLen >= m {
			num_m_groups -= (rightLen - m + 1)
		}

		// Calculate the length of the new merged group
		currentLen := 1 + leftLen + rightLen

		// Update group_len at the new boundaries of the merged group
		// The start of the new group is (pos - leftLen)
		// The end of the new group is (pos + rightLen)
		group_len[pos-leftLen] = currentLen
		group_len[pos+rightLen] = currentLen

		// The new merged group is formed. Increment num_m_groups for the groups it contains.
		if currentLen >= m {
			num_m_groups += (currentLen - m + 1)
		}

		// If there are any groups of size m, this step is a candidate for the latest step.
		if num_m_groups > 0 {
			ans = i + 1 // i is 0-indexed, step is 1-indexed
		}
	}

	return ans
}