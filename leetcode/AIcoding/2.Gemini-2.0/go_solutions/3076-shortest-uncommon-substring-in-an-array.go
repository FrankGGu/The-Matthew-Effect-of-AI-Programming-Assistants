import "fmt"

func shortestUncommonSubstr(arr []string) int {
	n := len(arr)
	minLen := 1
	for minLen <= 100 {
		found := true
		for i := 0; i < 1<<minLen; i++ {
			sub := ""
			for j := 0; j < minLen; j++ {
				if (i>>j)&1 == 1 {
					sub += "1"
				} else {
					sub += "0"
				}
			}
			if len(sub) != minLen {
				continue
			}

			isCommon := false
			for _, s := range arr {
				if contains(s, sub) {
					isCommon = true
					break
				}
			}
			if !isCommon {
				return minLen
			}
		}
		minLen++
	}
	return -1
}

func contains(s, sub string) bool {
	for i := 0; i <= len(s)-len(sub); i++ {
		if s[i:i+len(sub)] == sub {
			return true
		}
	}
	return false
}