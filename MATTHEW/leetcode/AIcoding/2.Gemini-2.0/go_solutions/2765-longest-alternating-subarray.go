func longestAlternatingSubarray(nums []int, threshold int) int {
	ans := 0
	for i := 0; i < len(nums); i++ {
		if nums[i] > threshold {
			continue
		}
		if nums[i]%2 != 0 {
			continue
		}
		curr := 1
		for j := i + 1; j < len(nums); j++ {
			if nums[j] > threshold {
				break
			}
			if nums[j]%2 == nums[j-1]%2 {
				break
			}
			curr++
		}
		if curr > ans {
			ans = curr
		}
	}
	return ans
}