import (
	"fmt"
	"strings"
)

func shortestSuperstring(a string, b string, c string) string {
	perms := []string{a + b + c, a + c + b, b + a + c, b + c + a, c + a + b, c + b + a}
	minLen := int(^uint(0) >> 1)
	res := ""
	for _, perm := range perms {
		s := perm
		s = merge(s, a, b)
		s = merge(s, s, c)
		if len(s) < minLen {
			minLen = len(s)
			res = s
		} else if len(s) == minLen && s < res {
			res = s
		}
	}
	return res
}

func merge(s string, s1 string, s2 string) string {
	i := strings.Index(s, s1)
	j := strings.Index(s, s2)
	if i != -1 && j != -1 {
		return s
	}

	for k := min(len(s1), len(s2)); k > 0; k-- {
		if strings.HasSuffix(s1, s2[:k]) {
			return s1 + s2[k:]
		}
		if strings.HasSuffix(s2, s1[:k]) {
			return s2 + s1[k:]
		}
	}
	return s1 + s2
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}