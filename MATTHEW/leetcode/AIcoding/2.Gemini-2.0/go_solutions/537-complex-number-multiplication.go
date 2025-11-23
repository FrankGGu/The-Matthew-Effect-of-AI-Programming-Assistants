import (
	"fmt"
	"strconv"
	"strings"
)

func complexNumberMultiply(a string, b string) string {
	aReal, aImag := parseComplex(a)
	bReal, bImag := parseComplex(b)

	real := aReal*bReal - aImag*bImag
	imag := aReal*bImag + aImag*bReal

	return fmt.Sprintf("%d+%di", real, imag)
}

func parseComplex(s string) (int, int) {
	parts := strings.Split(s, "+")
	real, _ := strconv.Atoi(parts[0])
	imagStr := strings.TrimSuffix(parts[1], "i")
	imag, _ := strconv.Atoi(imagStr)
	return real, imag
}