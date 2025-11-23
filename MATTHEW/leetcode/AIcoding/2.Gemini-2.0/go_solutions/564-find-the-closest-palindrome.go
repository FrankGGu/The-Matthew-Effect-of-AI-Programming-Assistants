import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func nearestPalindromic(n string) string {
	l := len(n)
	num, _ := strconv.ParseInt(n, 10, 64)
	candidates := []int64{
		int64(math.Pow10(l - 1)) - 1,
		int64(math.Pow10(l)) + 1,
	}

	prefix, _ := strconv.ParseInt(n[:(l+1)/2], 10, 64)

	for _, p := range []int64{prefix - 1, prefix, prefix + 1} {
		s := strconv.FormatInt(p, 10)
		t := s
		if l%2 == 1 {
			t = t[:len(t)-1]
		}
		for i := len(t) - 1; i >= 0; i-- {
			s += string(t[i])
		}
		val, _ := strconv.ParseInt(s, 10, 64)
		candidates = append(candidates, val)
	}

	ans := int64(math.MaxInt64)
	for _, candidate := range candidates {
		if candidate == num {
			continue
		}
		diff := abs(candidate - num)
		if diff < abs(ans-num) {
			ans = candidate
		} else if diff == abs(ans-num) && candidate < ans {
			ans = candidate
		}
	}
	return strconv.FormatInt(ans, 10)
}

func abs(x int64) int64 {
	if x < 0 {
		return -x
	}
	return x
}

func isPalindrome(s string) bool {
	s = strings.ToLower(s)
	for i := 0; i < len(s)/2; i++ {
		if s[i] != s[len(s)-i-1] {
			return false
		}
	}
	return true
}