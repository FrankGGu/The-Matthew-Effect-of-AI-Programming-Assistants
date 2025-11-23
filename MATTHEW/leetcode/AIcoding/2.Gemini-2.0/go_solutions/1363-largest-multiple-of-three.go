import "sort"

func largestMultipleOfThree(digits []int) string {
	sum := 0
	for _, d := range digits {
		sum += d
	}

	sort.Sort(sort.Reverse(sort.IntSlice(digits)))

	remove := func(rem int) bool {
		for i := len(digits) - 1; i >= 0; i-- {
			if digits[i]%3 == rem {
				digits = append(digits[:i], digits[i+1:]...)
				return true
			}
		}
		return false
	}

	if sum%3 == 1 {
		if !remove(1) {
			c := 0
			for i := len(digits) - 1; i >= 0; i-- {
				if digits[i]%3 == 2 {
					digits = append(digits[:i], digits[i+1:]...)
					c++
					if c == 2 {
						break
					}
				}
			}
			if c < 2 {
				return ""
			}
		}
	} else if sum%3 == 2 {
		if !remove(2) {
			c := 0
			for i := len(digits) - 1; i >= 0; i-- {
				if digits[i]%3 == 1 {
					digits = append(digits[:i], digits[i+1:]...)
					c++
					if c == 2 {
						break
					}
				}
			}
			if c < 2 {
				return ""
			}
		}
	}

	if len(digits) == 0 {
		return ""
	}

	if len(digits) == 1 && digits[0] == 0 {
		return "0"
	}

	res := ""
	allZero := true
	for _, d := range digits {
		if d != 0 {
			allZero = false
			break
		}
	}
	if allZero {
		return "0"
	}

	for _, d := range digits {
		res += string(rune('0' + d))
	}

	return res
}