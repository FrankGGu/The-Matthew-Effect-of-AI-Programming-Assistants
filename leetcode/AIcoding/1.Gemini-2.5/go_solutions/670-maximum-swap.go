import (
	"strconv"
)

func maximumSwap(num int) int {
	s := []byte(strconv.Itoa(num))
	n := len(s)

	for i := 0; i < n; i++ {
		maxDigit := s[i]
		maxIdx := i

		for j := i + 1; j < n; j++ {
			if s[j] >= maxDigit {
				maxDigit = s[j]
				maxIdx = j
			}
		}

		if maxIdx != i && s[maxIdx] > s[i] {
			s[i], s[maxIdx] = s[maxIdx], s[i]
			res, _ := strconv.Atoi(string(s))
			return res
		}
	}

	return num
}