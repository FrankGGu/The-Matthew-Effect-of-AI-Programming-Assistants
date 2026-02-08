package main

func longestNiceSubarray(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	maxLen := 0
	left := 0
	bitCounts := make([]int, 30)

	for right := 0; right < n; right++ {
		num := nums[right]

		for k := 0; k < 30; k++ {
			if (num>>k)&1 == 1 {
				bitCounts[k]++
			}
		}

		for {
			isNice := true
			currentWindowLen := right - left + 1
			for k := 0; k < 30; k++ {
				if bitCounts[k] > 0 && bitCounts[k] < currentWindowLen {
					isNice = false
					break
				}
			}

			if isNice {
				break
			}

			removeNum := nums[left]
			for k := 0; k < 30; k++ {
				if (removeNum>>k)&1 == 1 {
					bitCounts[k]--
				}
			}
			left++
		}

		if right-left+1 > maxLen {
			maxLen = right - left + 1
		}
	}

	return maxLen
}