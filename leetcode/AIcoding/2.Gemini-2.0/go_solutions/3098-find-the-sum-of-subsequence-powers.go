import "sort"

func sumSubseqWidths(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 0
	mod := 1000000007
	power := make([]int, n)
	power[0] = 1
	for i := 1; i < n; i++ {
		power[i] = (power[i-1] * 2) % mod
	}

	for i := 0; i < n; i++ {
		ans = (ans + nums[i]*power[i]) % mod
		ans = (ans - nums[i]*power[n-1-i] + mod) % mod
	}

	return ans
}