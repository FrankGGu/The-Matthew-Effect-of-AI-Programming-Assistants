import "fmt"

func findMinimumOperations(s1 string, s2 string, s3 string) int {
	n1, n2, n3 := len(s1), len(s2), len(s3)
	minLen := min(n1, min(n2, n3))
	count := 0
	for i := 0; i < minLen; i++ {
		if s1[i] == s2[i] && s2[i] == s3[i] {
			count++
		} else {
			break
		}
	}
	if count == 0 {
		return -1
	}
	return n1 - count + n2 - count + n3 - count
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}