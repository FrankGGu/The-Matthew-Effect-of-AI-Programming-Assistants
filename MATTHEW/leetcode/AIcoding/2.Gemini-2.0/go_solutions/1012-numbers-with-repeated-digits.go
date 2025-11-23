func numDupDigitsAtMostN(n int) int {
	digits := []int{}
	for x := n + 1; x > 0; x /= 10 {
		digits = append(digits, x%10)
	}
	for i, j := 0, len(digits)-1; i < j; i, j = i+1, j-1 {
		digits[i], digits[j] = digits[j], digits[i]
	}

	count := 0
	length := len(digits)
	for i := 1; i < length; i++ {
		count += 9 * A(9, i-1)
	}

	seen := map[int]bool{}
	for i := 0; i < length; i++ {
		for j := 0; j < digits[i]; j++ {
			if i == 0 && j == 0 {
				continue
			}
			if !seen[j] {
				count += A(9-i, length-i-1)
			}
		}
		if seen[digits[i]] {
			break
		}
		seen[digits[i]] = true
		if i == length-1 {
			count++
		}
	}

	return n - count
}

func A(m, n int) int {
	res := 1
	for i := 0; i < n; i++ {
		res *= (m - i)
	}
	return res
}