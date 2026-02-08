import (
	"sort"
	"strconv"
)

func smallestNumber(num int64) int64 {
	s := strconv.FormatInt(num, 10)
	digits := []int{}
	for _, r := range s {
		digits = append(digits, int(r-'0'))
	}

	if num >= 0 {
		sort.Ints(digits)
		if digits[0] == 0 {
			for i := 0; i < len(digits); i++ {
				if digits[i] != 0 {
					digits[0], digits[i] = digits[i], digits[0]
					break
				}
			}
		}
	} else {
		sort.Sort(sort.Reverse(sort.IntSlice(digits)))
	}

	res := ""
	for _, d := range digits {
		res += strconv.Itoa(d)
	}

	ans, _ := strconv.ParseInt(res, 10, 64)
	if num < 0 {
		return -ans
	}
	return ans
}