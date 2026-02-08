func countAndSay(n int) string {
	if n == 1 {
		return "1"
	}

	prev := "1"

	for i := 2; i <= n; i++ {
		var currentBuilder strings.Builder
		count := 1

		for j := 0; j < len(prev); j++ {
			if j+1 < len(prev) && prev[j] == prev[j+1] {
				count++
			} else {
				currentBuilder.WriteString(strconv.Itoa(count))
				currentBuilder.WriteByte(prev[j])
				count = 1 
			}
		}
		prev = currentBuilder.String()
	}

	return prev
}