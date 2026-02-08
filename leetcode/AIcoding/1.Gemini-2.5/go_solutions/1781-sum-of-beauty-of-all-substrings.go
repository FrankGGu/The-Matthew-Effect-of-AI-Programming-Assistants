func beautySum(s string) int {
	n := len(s)
	totalBeauty := 0

	for i := 0; i < n; i++ {
		freq := [26]int{} // Frequency array for 'a' through 'z' for the current substring s[i...j]

		for j := i