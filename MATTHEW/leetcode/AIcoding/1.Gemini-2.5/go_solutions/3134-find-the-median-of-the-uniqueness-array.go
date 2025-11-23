package main

func findTheMedianOfUniquenessArray(nums []int) int {
	n := len(nums)
	totalSubarrays := int64(n) * int64(n+1) / 2
	k := (totalSubarrays + 1) / 2

	check := func(x int) int64 {
		count := int64(0)
		left := 0
		freq := make(map[int]int)
		uniqueCount := 0

		for right := 0; right < n; right++ {
			freq[nums[right]]++
			if freq[nums[right]] == 1 {
				uniqueCount++
			}

			for uniqueCount > x {
				freq[nums[left]]--
				if freq[nums[left]] == 0 {
					uniqueCount--
				}
				left++
			}
			count += int64(right - left + 1)
		}
		return count
	}

	low := 1
	high := n
	ans := n

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) >= k {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}