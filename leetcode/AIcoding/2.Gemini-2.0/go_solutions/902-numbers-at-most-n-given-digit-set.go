import (
	"strconv"
)

func atMostNGivenDigitSet(digits []string, n int) int {
	s := strconv.Itoa(n)
	k := len(s)
	ans := 0
	m := len(digits)

	for i := 1; i < k; i++ {
		ans += pow(m, i)
	}

	for i := 0; i < k; i++ {
		hasSamePrefix := false
		for _, d := range digits {
			if d[0] < s[i] {
				ans += pow(m, k-i-1)
			} else if d[0] == s[i] {
				hasSamePrefix = true
			}
		}
		if !hasSamePrefix {
			return ans
		}
		if i == k-1 {
			ans++
		}
	}

	return ans
}

func pow(x, n int) int {
	res := 1
	for ; n > 0; n-- {
		res *= x
	}
	return res
}