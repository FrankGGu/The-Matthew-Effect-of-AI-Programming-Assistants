import (
	"strconv"
	"strings"
)

func maxDiff(num int) int {
	s := strconv.Itoa(num)

	// Calculate max_val
	maxStr := s
	digitToChangeForMax := ' '
	for _, char := range s {
		if char != '9' {
			digitToChangeForMax = char
			break
		}
	}

	if digitToChangeForMax != ' ' {
		maxStr = strings.ReplaceAll(s, string(digitToChangeForMax), "9")
	}
	maxVal, _ := strconv.Atoi(maxStr)

	// Calculate min_val
	minStr := s
	digitToChangeForMin := ' '
	targetDigitForMin := ' '

	if s[0] != '1' {
		digitToChangeForMin = rune(s[0])
		targetDigitForMin = '1'
	} else {
		for i := 1; i < len(s); i++ {
			if s[i] != '0' && s[i] != '1' {
				digitToChangeForMin = rune(s[i])
				targetDigitForMin = '0'
				break
			}
		}
	}

	if digitToChangeForMin != ' ' {
		minStr = strings.ReplaceAll(s, string(digitToChangeForMin), string(targetDigitForMin))
	}
	minVal, _ := strconv.Atoi(minStr)

	return maxVal - minVal
}