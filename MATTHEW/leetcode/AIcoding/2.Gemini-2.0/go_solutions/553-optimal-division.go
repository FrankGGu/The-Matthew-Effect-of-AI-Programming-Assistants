import (
	"fmt"
	"strconv"
)

func optimalDivision(nums []int) string {
	n := len(nums)
	if n == 1 {
		return strconv.Itoa(nums[0])
	}
	if n == 2 {
		return strconv.Itoa(nums[0]) + "/" + strconv.Itoa(nums[1])
	}
	res := strconv.Itoa(nums[0]) + "/("
	for i := 1; i < n; i++ {
		res += strconv.Itoa(nums[i])
		if i != n-1 {
			res += "/"
		}
	}
	res += ")"
	return res
}