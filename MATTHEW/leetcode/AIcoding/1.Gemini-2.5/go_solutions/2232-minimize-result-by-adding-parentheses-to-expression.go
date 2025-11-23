import (
	"math"
	"strconv"
	"strings"
)

func minimizeResult(expression string) string {
	plusIdx := strings.Index(expression, "+")
	num1FullStr := expression[0:plusIdx]
	num2FullStr := expression[plusIdx+1:]

	minResult := math.MaxInt64
	minExpression := ""

	// i represents the length of the prefix of num1_full_str that is outside the parentheses.
	// So, num1_prefix_str = num1_full_str[0:i]
	// And num1_inside_str = num1_full_str[i:]
	// num1_inside_str must be non-empty, so i cannot be len(num1_full_str).
	for i := 0; i < len(num1FullStr); i++ {
		num1PrefixStr := num1FullStr[0:i]
		num1InsideStr := num1FullStr[i:]

		// k represents the length of the prefix of num2_full_str that is inside the parentheses.
		// So, num2_inside_str = num2_full_str[0:k]
		// And num2_suffix_str = num2_full_str[k:]
		// num2_inside_str must be non-empty, so k must be at least 1.
		for k := 1; k <= len(num2FullStr); k++ {
			num2InsideStr := num2FullStr[0:k]
			num2SuffixStr := num2FullStr[k:]

			prefixVal := 1
			if num1PrefixStr != "" {
				prefixVal, _ = strconv.Atoi(num1PrefixStr)
			}

			num1InsideVal, _ := strconv.Atoi(num1InsideStr)
			num2InsideVal, _ := strconv.Atoi(num2InsideStr)

			suffixVal := 1
			if num2SuffixStr != "" {
				suffixVal, _ = strconv.Atoi(num2SuffixStr)
			}

			currentResult := prefixVal * (num1InsideVal + num2InsideVal) * suffixVal

			if currentResult < minResult {
				minResult = currentResult
				var sb strings.Builder
				sb.WriteString(num1PrefixStr)
				sb.WriteString("(")
				sb.WriteString(num1InsideStr)
				sb.WriteString("+")
				sb.WriteString(num2InsideStr)
				sb.WriteString(")")
				sb.WriteString(num2SuffixStr)
				minExpression = sb.String()
			}
		}
	}

	return minExpression
}