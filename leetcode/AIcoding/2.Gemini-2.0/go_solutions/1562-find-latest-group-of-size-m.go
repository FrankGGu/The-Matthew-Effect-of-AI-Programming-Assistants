func findLatestStep(arr []int, m int) int {
	n := len(arr)
	if m > n {
		return -1
	}

	length := make([]int, n+2)
	count := make([]int, n+1)
	ans := -1

	for i, a := range arr {
		left := length[a-1]
		right := length[a+1]
		length[a-left] = left + right + 1
		length[a+right] = left + right + 1
		length[a] = left + right + 1

		count[left]--
		count[right]--
		count[left+right+1]++

		if count[m] > 0 {
			ans = i + 1
		}
	}

	if count[m] > 0 {
		return ans
	}
	return -1
}