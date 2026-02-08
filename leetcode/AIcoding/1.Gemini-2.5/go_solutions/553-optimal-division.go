import (
	"strconv"
	"strings"
)

func optimalDivision(nums []int) string {
	n := len(nums)
	if n == 1 {
		return strconv.Itoa(nums[0])
	}
	if n == 2 {
		return strconv.Itoa(nums[0]) + "/" + strconv.Itoa(nums[1])
	}

	var sb strings.Builder
	sb.WriteString(strconv.Itoa(nums[0]))
	sb.WriteString("/(")
	for i := 1; i < n; i++ {
		sb.WriteString(strconv.Itoa(nums[i]))
		if i < n-1 {
			sb.WriteString("/")
		}
	}
	sb.WriteString(")")
	return sb.String()
}