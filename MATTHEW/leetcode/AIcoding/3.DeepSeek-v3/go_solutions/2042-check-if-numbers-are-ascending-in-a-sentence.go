import (
	"strconv"
	"strings"
)

func areNumbersAscending(s string) bool {
	words := strings.Split(s, " ")
	prev := -1
	for _, word := range words {
		if num, err := strconv.Atoi(word); err == nil {
			if num <= prev {
				return false
			}
			prev = num
		}
	}
	return true
}