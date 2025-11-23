func mostFrequent(nums []int, key int) int {
	count := make(map[int]int)
	for i := 0; i < len(nums)-1; i++ {
		if nums[i] == key {
			count[nums[i+1]]++
		}
	}
	maxCount := 0
	ans := 0
	for num, c := range count {
		if c > maxCount {
			maxCount = c
			ans = num
		}
	}
	return ans
}