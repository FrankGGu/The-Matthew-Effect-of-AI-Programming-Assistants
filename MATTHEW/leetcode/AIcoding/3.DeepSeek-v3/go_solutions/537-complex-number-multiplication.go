import (
	"strconv"
	"strings"
)

func complexNumberMultiply(num1 string, num2 string) string {
	parse := func(s string) (int, int) {
		parts := strings.Split(s[:len(s)-1], "+")
		real, _ := strconv.Atoi(parts[0])
		imag, _ := strconv.Atoi(parts[1])
		return real, imag
	}
	a, b := parse(num1)
	c, d := parse(num2)
	realPart := a*c - b*d
	imagPart := a*d + b*c
	return strconv.Itoa(realPart) + "+" + strconv.Itoa(imagPart) + "i"
}