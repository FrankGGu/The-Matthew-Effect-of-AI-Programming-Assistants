import "sort"

func sumSubseqWidths(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 0
	mod := 1000000007
	pow := make([]int, n)
	pow[0] = 1
	for i := 1; i < n; i++ {
		pow[i] = (pow[i-1] * 2) % mod
	}

	for i := 0; i < n; i++ {
		ans = (ans + nums[i]*pow[i] - nums[i]*pow[n-1-i]) % mod
	}

	if ans < 0 {
		ans += mod
	}
	return ans
}