func zeroFilledSubarray(nums []int) int64 {
	var ans int64
	var cnt int64
	for _, num := range nums {
		if num == 0 {
			cnt++
			ans += cnt
		} else {
			cnt = 0
		}
	}
	return ans
}