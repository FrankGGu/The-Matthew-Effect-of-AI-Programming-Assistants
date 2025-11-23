import "strconv"

func queryString(s string, n int) bool {
	for i := n; i > n/2; i-- {
		binary := strconv.FormatInt(int64(i), 2)
		if !contains(s, binary) {
			return false
		}
	}
	return true
}

func contains(s, sub string) bool {
	for i := 0; i <= len(s)-len(sub); i++ {
		if s[i:i+len(sub)] == sub {
			return true
		}
	}
	return false
}