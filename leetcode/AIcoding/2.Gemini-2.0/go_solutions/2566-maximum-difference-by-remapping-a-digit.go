import (
	"strconv"
)

func maxDiff(num int) int {
	s := strconv.Itoa(num)
	n := len(s)

	maxNum := num
	minNum := num

	for i := 0; i < n; i++ {
		digit := s[i]
		maxRep := '9'
		minRep := '0'
		if i == 0 {
			minRep = '1'
		}

		maxStr := ""
		minStr := ""

		for j := 0; j < n; j++ {
			if s[j] == digit {
				maxStr += string(maxRep)
				minStr += string(minRep)
			} else {
				maxStr += string(s[j])
				minStr += string(s[j])
			}
		}

		maxVal, _ := strconv.Atoi(maxStr)
		minVal, _ := strconv.Atoi(minStr)

		if maxVal > maxNum {
			maxNum = maxVal
		}

		if minVal < minNum {
			minNum = minVal
		}
	}

	return maxNum - minNum
}