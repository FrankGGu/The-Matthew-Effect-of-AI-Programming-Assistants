func minKBitFlips(nums []int, k int) int {
	n := len(nums)
	diff := make([]int, n+1)
	flips := 0
	ans := 0
	for i := 0; i < n; i++ {
		flips += diff[i]
		if (nums[i]+flips)%2 == 0 {
			if i+k > n {
				return -1
			}
			ans++
			flips++
			diff[i+k]--
		}
	}
	return ans
}