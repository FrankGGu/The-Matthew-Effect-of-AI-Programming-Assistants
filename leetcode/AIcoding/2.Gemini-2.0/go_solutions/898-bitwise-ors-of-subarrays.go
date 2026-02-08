func subarrayBitwiseORs(arr []int) []int {
	ans := make(map[int]bool)
	curr := make(map[int]bool)
	for _, x := range arr {
		newCurr := make(map[int]bool)
		newCurr[x] = true
		for y := range curr {
			newCurr[x|y] = true
		}
		curr = newCurr
		for y := range curr {
			ans[y] = true
		}
	}
	res := []int{}
	for x := range ans {
		res = append(res, x)
	}
	return res
}