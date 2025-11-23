func findDifferentBinaryString(nums []string) string {
	n := len(nums)
	res := ""
	for i := 0; i < n; i++ {
		if nums[i][i] == '0' {
			res += "1"
		} else {
			res += "0"
		}
	}
	return res
}