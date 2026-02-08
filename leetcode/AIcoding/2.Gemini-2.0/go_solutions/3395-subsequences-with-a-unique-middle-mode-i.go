func uniqueSubsequenceMiddleMode(nums []int) int {
	n := len(nums)
	count := 0
	for i := 0; i < (1 << n); i++ {
		subsequence := []int{}
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				subsequence = append(subsequence, nums[j])
			}
		}
		if len(subsequence) > 0 {
			if isUniqueMiddleMode(subsequence) {
				count++
			}
		}
	}
	return count
}

func isUniqueMiddleMode(nums []int) bool {
	n := len(nums)
	if n%2 == 0 {
		return false
	}

	middle := nums[n/2]
	freq := make(map[int]int)
	for _, num := range nums {
		freq[num]++
	}

	maxFreq := 0
	mode := -1
	for num, f := range freq {
		if f > maxFreq {
			maxFreq = f
			mode = num
		}
	}

	if maxFreq == 1 && n > 1 {
		return false
	}

	if mode != middle {
		return false
	}

	modes := []int{}
	maxFreq = 0
	for num, f := range freq {
		if f > maxFreq {
			modes = []int{num}
			maxFreq = f
		} else if f == maxFreq {
			modes = append(modes, num)
		}
	}

	if len(modes) > 1 {
		return false
	}

	return true
}