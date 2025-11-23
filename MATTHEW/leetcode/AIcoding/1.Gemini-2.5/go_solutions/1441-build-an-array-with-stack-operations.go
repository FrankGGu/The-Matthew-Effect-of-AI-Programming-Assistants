func buildArray(target []int, n int) []string {
	operations := []string{}
	targetIdx := 0
	for i := 1; i <= n && targetIdx < len(target); i++ {
		if i == target[targetIdx] {
			operations = append(operations, "Push")
			targetIdx++
		} else {
			operations = append(operations, "Push")
			operations = append(operations, "Pop")
		}
	}
	return operations
}