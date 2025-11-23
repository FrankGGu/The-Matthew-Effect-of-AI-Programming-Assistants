import (
	"fmt"
	"strconv"
)

func smallestNumber(n int) int {
	if n == 0 {
		return 10
	}
	if n == 1 {
		return 1
	}

	digits := []int{}
	for i := 9; i >= 2; i-- {
		for n%i == 0 {
			digits = append(digits, i)
			n /= i
		}
	}

	if n != 1 {
		return -1
	}

	result := 0
	for i := len(digits) - 1; i >= 0; i-- {
		result = result*10 + digits[i]
	}

	return result
}

func smallestDivisibleDigitProduct(n int) int {
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}

	digits := []int{}
	for i := 9; i >= 2; i-- {
		for n%i == 0 {
			digits = append(digits, i)
			n /= i
		}
	}

	if n != 1 {
		return -1
	}

	result := 0
	for i := len(digits) - 1; i >= 0; i-- {
		result = result*10 + digits[i]
	}

	return result
}

func smallestDivisibleDigitProductII(n int) string {
	if n == 0 {
		return "0"
	}
	if n == 1 {
		return "1"
	}

	digits := []string{}
	for i := 9; i >= 2; i-- {
		for n%i == 0 {
			digits = append(digits, strconv.Itoa(i))
			n /= i
		}
	}

	if n != 1 {
		return "-1"
	}

	result := ""
	for i := len(digits) - 1; i >= 0; i-- {
		result += digits[i]
	}

	return result
}