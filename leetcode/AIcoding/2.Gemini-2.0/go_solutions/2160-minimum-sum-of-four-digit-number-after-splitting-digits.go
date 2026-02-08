import (
	"sort"
	"strconv"
)

func minimumSum(num int) int {
	s := strconv.Itoa(num)
	digits := []int{}
	for _, r := range s {
		digit, _ := strconv.Atoi(string(r))
		digits = append(digits, digit)
	}
	sort.Ints(digits)
	return (digits[0]+digits[1])*10 + digits[2] + digits[3]
}