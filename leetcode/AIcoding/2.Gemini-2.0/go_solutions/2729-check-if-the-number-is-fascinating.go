import (
	"strconv"
)

func isFascinating(n int) bool {
	s := strconv.Itoa(n) + strconv.Itoa(2*n) + strconv.Itoa(3*n)
	if len(s) != 9 {
		return false
	}
	counts := make(map[rune]int)
	for _, r := range s {
		if r == '0' {
			return false
		}
		counts[r]++
	}
	for i := 1; i <= 9; i++ {
		r := rune('0' + i)
		if counts[r] != 1 {
			return false
		}
	}
	return true
}