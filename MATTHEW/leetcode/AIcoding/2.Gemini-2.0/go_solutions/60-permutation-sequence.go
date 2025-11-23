import (
	"strconv"
)

func getPermutation(n int, k int) string {
	nums := make([]int, n)
	fact := make([]int, n)
	fact[0] = 1
	for i := 1; i < n; i++ {
		fact[i] = fact[i-1] * i
	}
	for i := 1; i <= n; i++ {
		nums[i-1] = i
	}
	k--
	res := ""
	for i := n - 1; i >= 0; i-- {
		index := k / fact[i]
		res += strconv.Itoa(nums[index])
		nums = append(nums[:index], nums[index+1:]...)
		k %= fact[i]
	}
	return res
}