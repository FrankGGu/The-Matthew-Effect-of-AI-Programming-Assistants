func minimumOperations(num string) int {
	n := len(num)
	ans := n
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			val := int(num[i]-'0')*10 + int(num[j]-'0')
			if val%25 == 0 {
				count := n - j - 1
				for k := 0; k < i; k++ {
					count++
				}
				ans = min(ans, count)
			}
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}