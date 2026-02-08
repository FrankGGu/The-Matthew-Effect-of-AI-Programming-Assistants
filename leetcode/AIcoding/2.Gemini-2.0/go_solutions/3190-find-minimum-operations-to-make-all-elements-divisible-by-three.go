func minOperations(nums []int) int {
	sum := 0
	one := 1000000000
	two := 1000000000
	for _, num := range nums {
		sum += num
		if num%3 == 1 {
			if num < one {
				two = one
				one = num
			} else if num < two {
				two = num
			}
		} else if num%3 == 2 {
			if num < one {
				two = one
				one = num
			} else if num < two {
				two = num
			}
		}
	}
	if sum%3 == 0 {
		return 0
	} else if sum%3 == 1 {
		if one != 1000000000 && two != 1000000000 {
			return min(one+two, one*10000) / one + min(one+two, one*10000) % one
		} else if one != 1000000000 {
			return 1
		} else {
			return -1
		}
	} else {
		oneVal := 1000000000
		twoVal := 1000000000
		for _, num := range nums {
			if num%3 == 1 {
				if num < oneVal {
					oneVal = num
				}
			}
			if num%3 == 2 {
				if num < twoVal {
					twoVal = num
				}
			}
		}
		if twoVal != 1000000000 && oneVal != 1000000000 {
			return min(oneVal+oneVal, twoVal)
		} else if twoVal != 1000000000 {
			return 1
		} else {
			return -1
		}
	}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}