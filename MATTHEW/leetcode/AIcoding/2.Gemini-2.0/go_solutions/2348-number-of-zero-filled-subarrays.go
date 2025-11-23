func zeroFilledSubarray(nums []int) int64 {
	var ans int64
	count := 0
	for _, num := range nums {
		if num == 0 {
			count++
			ans += int64(count)
		} else {
			count = 0
		}
	}
	return ans
}