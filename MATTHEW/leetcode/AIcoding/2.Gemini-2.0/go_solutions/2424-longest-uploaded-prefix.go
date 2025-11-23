func longestUploadedPrefix(n int, uploads []int) int {
	uploaded := make([]bool, n+1)
	maxPrefix := 0
	for _, upload := range uploads {
		uploaded[upload] = true
		for i := maxPrefix + 1; i <= n; i++ {
			if !uploaded[i] {
				break
			}
			maxPrefix = i
		}
	}
	return maxPrefix
}