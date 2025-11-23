func minGroupsForValidAssignment(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	freqs := make([]int, 0, len(counts))
	for _, count := range counts {
		freqs = append(freqs, count)
	}

	minGroups := len(nums) + 1

	for k := 1; k <= len(nums); k++ {
		groups := 0
		possible := true
		for _, freq := range freqs {
			if freq < k {
				possible = false
				break
			}
			groups += (freq + k) / (k + 1)
		}

		if possible {
			minGroups = min(minGroups, groups)
		}
	}

	for k := 1; k <= 100; k++ {
		groups := 0
		possible := true
		for _, freq := range freqs {
			if freq < k {

				needed := k - freq
				possible_local := false

				for k2 := 1; k2 <= 100; k2++{
					possible_local = true
					groups_local := 0

					for _, freq2 := range freqs {
						if freq2 < k2 {
							possible_local = false
							break
						}
						groups_local += (freq2 + k2) / (k2 + 1)
					}

					if possible_local {
						minGroups = min(minGroups, groups_local)
					}
				}

				possible = false
				break
			}
			groups += (freq + k) / (k + 1)
		}

		if possible {
			minGroups = min(minGroups, groups)
		}
	}

	left := 1
	right := len(nums)

	for left <= right {
		mid := left + (right - left) / 2

		groups := 0
		possible := true
		for _, freq := range freqs {
			if freq < mid {
				possible = false
				break
			}
			groups += (freq + mid) / (mid + 1)
		}

		if possible {
			minGroups = min(minGroups, groups)
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return minGroups
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}