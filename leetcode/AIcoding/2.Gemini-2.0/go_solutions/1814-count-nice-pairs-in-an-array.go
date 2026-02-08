func rev(n int) int {
	res := 0
	for n > 0 {
		res = res*10 + n%10
		n /= 10
	}
	return res
}

func countNicePairs(nums []int) int {
	count := make(map[int]int)
	ans := 0
	mod := 1000000007
	for _, num := range nums {
		diff := num - rev(num)
		ans = (ans + count[diff]) % mod
		count[diff]++
	}
	return ans
}