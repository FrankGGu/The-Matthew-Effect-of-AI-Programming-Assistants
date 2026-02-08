import (
	"strings"
)

func originalDigits(s string) string {
	charCounts := make([]int, 26)
	for _, r := range s {
		charCounts[r-'a']++
	}

	digitCounts := make([]int, 10)

	// Deduce digits based on unique character occurrences
	// 'z' is only in "zero"
	digitCounts[0] = charCounts['z'-'a']
	// 'w' is only in "two"
	digitCounts[2] = charCounts['w'-'a']
	// 'u' is only in "four"
	digitCounts[4] = charCounts['u'-'a']
	// 'x' is only in "six"
	digitCounts[6] = charCounts['x'-'a']
	// 'g' is only in "eight"
	digitCounts[8] = charCounts['g'-'a']

	// Deduce digits using characters that become unique after removing counts of known digits
	// 'h' is in "three" and "eight"
	digitCounts[3] = charCounts['h'-'a'] - digitCounts[8]
	// 'f' is in "four" and "five"
	digitCounts[5] = charCounts['f'-'a'] - digitCounts[4]
	// 's' is in "six" and "seven"
	digitCounts[7] = charCounts['s'-'a'] - digitCounts[6]

	// Deduce remaining digits
	// 'o' is in "zero", "one", "two", "four"
	digitCounts[1] = charCounts['o'-'a'] - digitCounts[0] - digitCounts[2] - digitCounts[4]
	// 'i' is in "five", "six", "eight", "nine"
	digitCounts[9] = charCounts['i'-'a'] - digitCounts[5] - digitCounts[6] - digitCounts[8]

	var result strings.Builder
	for i := 0; i < 10; i++ {
		for j := 0; j < digitCounts[i]; j++ {
			result.WriteByte(byte('0' + i))
		}
	}

	return result.String()
}