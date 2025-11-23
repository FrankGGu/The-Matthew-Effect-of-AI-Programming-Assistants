func lenLongestFibSubseq(A []int) int {
	n := len(A)
	index := make(map[int]int)
	for i, num := range A {
		index[num] = i
	}
	maxLength := 0
	dp := make(map[[2]int]int)

	for k := 0; k < n; k++ {
		for j := k - 1; j >= 0; j-- {
			i := index[A[k]-A[j]]
			if i >= 0 && i < j {
				dp[[2]int{j, k}] = dp[[2]int{i, j}] + 1
				maxLength = max(maxLength, dp[[2]int{j, k}] + 2)
			}
		}
	}
	if maxLength < 3 {
		return 0
	}
	return maxLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}