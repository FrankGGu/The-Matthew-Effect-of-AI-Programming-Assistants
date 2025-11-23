import (
	"sort"
	"strconv"
	"strings"
)

func largestNumber(nums []int) string {
	strs := make([]string, len(nums))
	for i, num := range nums {
		strs[i] = strconv.Itoa(num)
	}

	sort.Slice(strs, func(i, j int) bool {
		s1 := strs[i] + strs[j]
		s2 := strs[j] + strs[i]
		return s1 > s2
	})

	if strs[0] == "0" {
		return "0"
	}

	return strings.Join(strs, "")
}