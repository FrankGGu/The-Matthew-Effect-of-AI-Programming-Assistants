import (
	"strconv"
)

func alternateDigitSum(n int) int {
	s := strconv.Itoa(n)
	sum := 0
	sign := 1

	for i := 0; i < len(s); i++ {
		digit := int(s[i] - '0')
		sum += digit * sign
		sign *= -1
	}

	return sum
}