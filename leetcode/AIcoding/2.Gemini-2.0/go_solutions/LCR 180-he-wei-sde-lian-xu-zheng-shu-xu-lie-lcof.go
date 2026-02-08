import (
	"sort"
	"strconv"
)

func largestNumber(nums []int) string {
	sort.Slice(nums, func(i, j int) bool {
		s1 := strconv.Itoa(nums[i])
		s2 := strconv.Itoa(nums[j])
		return s1+s2 > s2+s1
	})

	res := ""
	for _, num := range nums {
		res += strconv.Itoa(num)
	}

	if res[0] == '0' && len(res) > 1 {
		return "0"
	}

	return res
}