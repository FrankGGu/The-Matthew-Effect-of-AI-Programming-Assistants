import "strings"

func licenseKeyFormatting(s string, k int) string {
	s = strings.ReplaceAll(s, "-", "")
	s = strings.ToUpper(s)
	n := len(s)
	if n == 0 {
		return ""
	}

	firstGroupSize := n % k
	if firstGroupSize == 0 {
		firstGroupSize = k
	}

	result := strings.Builder{}
	result.WriteString(s[:firstGroupSize])

	for i := firstGroupSize; i < n; i += k {
		result.WriteString("-")
		result.WriteString(s[i : i+k])
	}

	return result.String()
}