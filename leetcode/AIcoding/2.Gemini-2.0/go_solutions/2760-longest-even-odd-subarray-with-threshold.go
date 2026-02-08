func longestEvenOddSubarray(nums []int, threshold int) int {
	ans := 0
	for i := 0; i < len(nums); i++ {
		if nums[i]%2 == 0 && nums[i] <= threshold {
			curr := 1
			for j := i + 1; j < len(nums); j++ {
				if nums[j] <= threshold && nums[j]%2 != nums[j-1]%2 {
					curr++
				} else {
					break
				}
			}
			if curr > ans {
				ans = curr
			}
		}
	}
	return ans
}