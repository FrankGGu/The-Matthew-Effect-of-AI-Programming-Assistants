import (
	"fmt"
	"strings"
)

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

func fractionAddition(expression string) string {
	numerator := 0
	denominator := 1

	if expression[0] != '-' {
		expression = "+" + expression
	}

	r := strings.NewReader(expression)
	var num, den int
	var sign byte

	for {
		n, err := fmt.Fscanf(r, "%c%d/%d", &sign, &num, &den)
		if err != nil {
			break
		}
		if n != 3 {
			break
		}

		currentSign := 1
		if sign == '-' {
			currentSign = -1
		}

		num *= currentSign

		newNumerator := numerator*den + num*denominator
		newDenominator := denominator * den

		numerator = newNumerator
		denominator = newDenominator
	}

	commonDivisor := gcd(abs(numerator), denominator)

	numerator /= commonDivisor
	denominator /= commonDivisor

	return fmt.Sprintf("%d/%d", numerator, denominator)
}