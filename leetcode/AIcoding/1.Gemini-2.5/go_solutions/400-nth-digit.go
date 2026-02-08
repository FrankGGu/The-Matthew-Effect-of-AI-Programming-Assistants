import (
	"strconv"
)

func findNthDigit(n int) int {
	digits := 1
	count := 9
	start := 1

	for n > digits*count {
		n -= digits * count
		digits++
		count *= 10
		start *= 10
	}

	num := start + (n-1)/digits
	digitIndex := (n - 1) % digits

	numStr := strconv.Itoa(num)
	return int(numStr[digitIndex] - '0')
}