import (
	"sort"
	"strconv"
)

func maxConcatenatedNum(nums []int) string {
	sort.Slice(nums, func(i, j int) bool {
		si := strconv.Itoa(nums[i])
		sj := strconv.Itoa(nums[j])
		return si+sj > sj+si
	})
	res := ""
	for _, num := range nums {
		res += strconv.Itoa(num)
	}
	if res[0] == '0' {
		return "0"
	}
	return res
}