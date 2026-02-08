func divideString(s string, k int, fill byte) []string {
	n := len(s)
	numGroups := (n + k - 1) / k
	result := make([]string, numGroups)

	for i := 0; i < numGroups; i++ {
		start := i * k
		end := (i + 1) * k

		if end <= n {
			result[i] = s[start:end]
		} else {
			var groupBuilder strings.Builder
			groupBuilder.WriteString(s[start:n])
			paddingNeeded := k - (n - start)
			for j := 0; j < paddingNeeded; j++ {
				groupBuilder.WriteByte(fill)
			}
			result[i] = groupBuilder.String()
		}
	}
	return result
}