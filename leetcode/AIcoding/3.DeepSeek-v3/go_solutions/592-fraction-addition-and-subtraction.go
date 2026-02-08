import (
	"fmt"
	"strconv"
	"strings"
)

func fractionAddition(expression string) string {
	numerator, denominator := 0, 1
	i, n := 0, len(expression)
	for i < n {
		sign := 1
		if expression[i] == '-' {
			sign = -1
			i++
		} else if expression[i] == '+' {
			sign = 1
			i++
		}
		num := 0
		for i < n && expression[i] >= '0' && expression[i] <= '9' {
			num = num*10 + int(expression[i]-'0')
			i++
		}
		num *= sign
		i++
		den := 0
		for i < n && expression[i] >= '0' && expression[i] <= '9' {
			den = den*10 + int(expression[i]-'0')
			i++
		}
		numerator = numerator*den + num*denominator
		denominator *= den
	}
	g := gcd(abs(numerator), denominator)
	numerator /= g
	denominator /= g
	return fmt.Sprintf("%d/%d", numerator, denominator)
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}