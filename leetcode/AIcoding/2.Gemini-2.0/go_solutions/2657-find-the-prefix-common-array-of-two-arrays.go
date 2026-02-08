func findThePrefixCommonArray(A []int, B []int) []int {
	n := len(A)
	C := make([]int, n)
	count := 0
	seen := make(map[int]int)
	for i := 0; i < n; i++ {
		seen[A[i]]++
		if seen[A[i]] == 2 {
			count++
		}
		seen[B[i]]++
		if seen[B[i]] == 2 {
			count++
		}
		C[i] = count
	}
	return C
}