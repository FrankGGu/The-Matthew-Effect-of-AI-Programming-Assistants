func grayCode(n int) []int {
	res := []int{0}

	for i := 0; i < n; i++ {
		numToAdd := 1 << i
		for j := len(res) - 1; j >= 0; j-- {
			res = append(res, res[j]+numToAdd)
		}
	}

	return res
}