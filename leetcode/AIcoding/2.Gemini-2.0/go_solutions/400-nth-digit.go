import (
	"fmt"
	"strconv"
)

func findNthDigit(n int) int {
	digits := 1
	count := 9
	for n > digits*count {
		n -= digits * count
		digits++
		count *= 10
	}

	num := (n-1)/digits + pow(10, digits-1)
	index := (n - 1) % digits

	s := strconv.Itoa(num)
	return int(s[index] - '0')
}

func pow(base, exp int) int {
	result := 1
	for i := 0; i < exp; i++ {
		result *= base
	}
	return result
}