func findThePrefixCommonArray(A []int, B []int) []int {
	n := len(A)
	res := make([]int, n)
	setA := make(map[int]bool)
	setB := make(map[int]bool)
	count := 0
	for i := 0; i < n; i++ {
		setA[A[i]] = true
		setB[B[i]] = true
		if setA[A[i]] && setB[A[i]] {
			count++
		}
		res[i] = count
	}
	return res
}