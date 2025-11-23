func crackSafe(n int, k int) string {
	if n == 1 {
		var sb strings.Builder
		for i := 0; i < k; i++ {
			sb.WriteString(strconv.Itoa(i))
		}