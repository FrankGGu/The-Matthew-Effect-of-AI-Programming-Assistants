func findEncryptedString(s string) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	arr := []string{}
	for i := 0; i < n; i++ {
		arr = append(arr, s[i:]+s[:i])
	}

	minStr := arr[0]
	for i := 1; i < n; i++ {
		if arr[i] < minStr {
			minStr = arr[i]
		}
	}

	return minStr
}