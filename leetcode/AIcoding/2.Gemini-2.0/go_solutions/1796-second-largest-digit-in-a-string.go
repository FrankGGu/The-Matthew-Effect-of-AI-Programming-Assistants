import (
	"strconv"
)

func secondHighest(s string) int {
	largest := -1
	secondLargest := -1

	for _, char := range s {
		if char >= '0' && char <= '9' {
			digit, _ := strconv.Atoi(string(char))
			if digit > largest {
				secondLargest = largest
				largest = digit
			} else if digit < largest && digit > secondLargest {
				secondLargest = digit
			}
		}
	}

	return secondLargest
}