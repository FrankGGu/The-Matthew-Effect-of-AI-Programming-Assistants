func minOperations(boxes string) []int {
	n := len(boxes)
	res := make([]int, n)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if boxes[j] == '1' {
				res[i] += abs(i - j)
			}
		}
	}
	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}