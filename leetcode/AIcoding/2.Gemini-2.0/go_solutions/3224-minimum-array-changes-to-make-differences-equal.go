func minChanges(nums []int, k int) int {
	n := len(nums)
	maxNum := 1024
	ans := 0
	for i := 0; i < k; i++ {
		count := make(map[int]int)
		length := 0
		for j := i; j < n; j += k {
			count[nums[j]]++
			length++
		}
		maxCount := 0
		for _, c := range count {
			if c > maxCount {
				maxCount = c
			}
		}
		ans += length - maxCount
	}
	return ans
}