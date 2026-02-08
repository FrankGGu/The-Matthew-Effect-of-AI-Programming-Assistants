func getMaxLen(nums []int) int {
	pos := 0
	neg := 0
	ans := 0
	for i := 0; i < len(nums); i++ {
		if nums[i] > 0 {
			pos++
			if neg > 0 {
				neg++
			}
		} else if nums[i] < 0 {
			temp := pos
			pos = neg
			neg = temp
			neg++
			if pos > 0 {
				pos++
			}
		} else {
			pos = 0
			neg = 0
		}
		if pos > ans {
			ans = pos
		}
	}
	return ans
}