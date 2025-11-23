func lexicalOrder(n int) []int {
	res := make([]int, 0, n)
	curr := 1
	for i := 0; i < n; i++ {
		res = append(res, curr)
		if curr*10 <= n {
			curr *= 10
		} else if curr%10 != 9 && curr+1 <= n {
			curr++
		} else {
			for curr > 0 && (curr%10 == 9 || curr+1 > n) {
				curr /= 10
			}
			curr++
		}
	}
	return res
}