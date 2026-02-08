import "strings"

func maximumOddBinaryNumber(s string) string {
	onesCount := 0
	for _, char := range s {
		if char == '1' {
			onesCount++
		}
	}

	n := len(s)
	var resultBuilder strings.Builder
	resultBuilder.Grow(n)

	for i := 0; i < onesCount-1; i++ {
		resultBuilder.WriteByte('1')
	}

	for i := 0; i < n-onesCount; i++ {
		resultBuilder.WriteByte('0')
	}

	resultBuilder.WriteByte('1')

	return resultBuilder.String()
}