import (
	"math"
)

func strongPasswordChecker(password string) int {
	n := len(password)
	missingTypes := 3
	hasLower := false
	hasUpper := false
	hasDigit := false
	for _, c := range password {
		if 'a' <= c && c <= 'z' {
			hasLower = true
		} else if 'A' <= c && c <= 'Z' {
			hasUpper = true
		} else if '0' <= c && c <= '9' {
			hasDigit = true
		}
	}
	if hasLower {
		missingTypes--
	}
	if hasUpper {
		missingTypes--
	}
	if hasDigit {
		missingTypes--
	}

	repeats := []int{}
	i := 0
	for i < n {
		j := i
		for j < n && password[i] == password[j] {
			j++
		}
		length := j - i
		if length >= 3 {
			repeats = append(repeats, length)
		}
		i = j
	}

	if n < 6 {
		return int(math.Max(float64(missingTypes), float64(6-n)))
	} else if n > 20 {
		diff := n - 20
		ans := diff
		for i := 1; i <= diff; i++ {
			for j := 0; j < len(repeats); j++ {
				if repeats[j] < 3 {
					continue
				}
				if repeats[j]%3 == (i-1)%3 {
					repeats[j]--
					diff--
					ans--
					if diff == 0 {
						break
					}
				}
			}
		}

		ans += missingTypes
		return ans
	} else {
		return int(math.Max(float64(missingTypes), float64(len(repeats))))
	}
}