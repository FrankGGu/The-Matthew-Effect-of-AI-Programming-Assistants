func countPowerfulIntegers(start int64, finish int64, limit int, s string) int64 {
	n := len(s)
	startStr := toString(start)
	finishStr := toString(finish)

	var dp func(string, int, bool, bool) int64
	dp = func(numStr string, idx int, isLessStart bool, isMoreFinish bool) int64 {
		if idx == len(numStr) {
			return 1
		}

		res := int64(0)
		startDigit := 0
		if !isLessStart {
			startDigit = int(startStr[len(startStr)-len(numStr)+idx] - '0')
		}
		finishDigit := 9
		if !isMoreFinish {
			finishDigit = int(finishStr[len(finishStr)-len(numStr)+idx] - '0')
		}

		for digit := startDigit; digit <= finishDigit; digit++ {
			if digit > limit {
				continue
			}

			nextIsLessStart := isLessStart || digit > startDigit
			nextIsMoreFinish := isMoreFinish || digit < finishDigit
			res += dp(numStr, idx+1, nextIsLessStart, nextIsMoreFinish)
		}

		return res
	}

	count := func(upperBound int64) int64 {
		upperBoundStr := toString(upperBound)
		if len(upperBoundStr) < n {
			return 0
		}

		if len(upperBoundStr) == n {
			num, _ := stringToInt(s)
			if num > upperBound {
				return 0
			}
			return 1
		}

		numStr := upperBoundStr[:len(upperBoundStr)-n]
		return dp(numStr, 0, false, false)
	}

	return count(finish) - count(start-1)
}

func toString(n int64) string {
	if n == 0 {
		return "0"
	}

	digits := []byte{}
	for n > 0 {
		digits = append([]byte{byte('0' + n%10)}, digits...)
		n /= 10
	}
	return string(digits)
}

func stringToInt(s string) (int64, bool) {
	result := int64(0)
	for _, r := range s {
		digit := r - '0'
		if digit < 0 || digit > 9 {
			return 0, false
		}
		result = result*10 + int64(digit)
	}
	return result, true
}