import (
	"strconv"
	"strings"
)

func areNumbersAscending(s string) bool {
	prevNum := -0x7fffffff - 1 // Initialize with the smallest possible int32 value to ensure any valid number is greater

	words := strings.Fields(s)

	for _, word := range words {
		num, err := strconv.Atoi(word)
		if err == nil { // It's a number
			if num <= prevNum {
				return false
			}
			prevNum = num
		}
	}

	return true
}