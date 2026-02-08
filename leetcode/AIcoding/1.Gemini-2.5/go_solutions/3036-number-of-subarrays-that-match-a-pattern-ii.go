package main

func findMatchingSubarrays(nums []int, pattern []int) int {
	n := len(nums)
	m := len(pattern)

	if m == 0 {
		return 0
	}
	if n-1 < m {
		return 0
	}

	b := make([]int, n-1)
	for i := 0; i < n-1; i++ {
		if nums[i+1] > nums[i] {
			b[i] = 1
		} else if nums[i+1] == nums[i] {
			b[i] = 0
		} else {
			b[i] = -1
		}
	}

	lps := make([]int, m)
	length := 0
	for i := 1; i < m; {
		if pattern[i] == pattern[length] {
			length++
			lps[i] = length
			i++
		} else {
			if length != 0 {
				length = lps[length-1]
			} else {
				lps[i] = 0
				i++
			}
		}
	}

	count := 0
	i := 0
	j := 0

	for i < n-1 {
		if pattern[j] == b[i] {
			i++
			j++
		}

		if j == m {
			count++
			j = lps[j-1]
		} else if i < n-1 && pattern[j] != b[i] {
			if j != 0 {
				j = lps[j-1]
			} else {
				i++
			}
		}
	}

	return count
}