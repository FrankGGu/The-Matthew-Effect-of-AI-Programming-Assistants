func maxPartitionAfterOperations(s string, k int) int {
	n := len(s)
	if k > 26 {
		return n
	}
	ans := 1
	curr := ""
	for i := 0; i < n; i++ {
		found := false
		for j := 0; j < len(curr); j++ {
			if curr[j] == s[i] {
				found = true
				break
			}
		}
		if !found {
			if len(curr) == k {
				ans++
				curr = string(s[i])
			} else {
				curr += string(s[i])
			}
		}
	}
	return ans
}