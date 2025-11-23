import (
	"strconv"
)

func findTheArrayConcVal(nums []int) int64 {
	n := len(nums)
	l, r := 0, n-1
	var res int64
	for l <= r {
		if l == r {
			res += int64(nums[l])
		} else {
			s := strconv.Itoa(nums[l]) + strconv.Itoa(nums[r])
			val, _ := strconv.ParseInt(s, 10, 64)
			res += val
		}
		l++
		r--
	}
	return res
}