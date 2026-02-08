import (
	"sort"
	"strconv"
)

func smallestNumber(num int64) int64 {
	if num == 0 {
		return 0
	}
	negative := num < 0
	if negative {
		num = -num
	}
	s := strconv.FormatInt(num, 10)
	digits := []byte(s)
	if negative {
		sort.Slice(digits, func(i, j int) bool {
			return digits[i] > digits[j]
		})
		res, _ := strconv.ParseInt(string(digits), 10, 64)
		return -res
	} else {
		sort.Slice(digits, func(i, j int) bool {
			return digits[i] < digits[j]
		})
		i := 0
		for i < len(digits) && digits[i] == '0' {
			i++
		}
		if i > 0 && i < len(digits) {
			digits[0], digits[i] = digits[i], digits[0]
		}
		res, _ := strconv.ParseInt(string(digits), 10, 64)
		return res
	}
}