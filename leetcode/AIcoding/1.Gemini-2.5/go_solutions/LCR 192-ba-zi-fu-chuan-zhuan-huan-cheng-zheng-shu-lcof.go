import "math"

func myAtoi(s string) int {
	n := len(s)
	i := 0

	// 1. Read and ignore leading whitespace
	for i < n && s[i] == ' ' {
		i++
	}

	// If string is empty or only contains whitespace
	if