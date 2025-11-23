func combine(n int, k int) [][]int {
	res := [][]int{}
	var backtrack func(start int, comb []int)
	backtrack = func(start int, comb []int) {
		if len(comb) == k {
			temp := make([]int, k)
			copy(temp, comb)
			res = append(res, temp)
			return
		}
		for i := start; i <= n; i++ {
			comb = append(comb, i)
			backtrack(i+1, comb)
			comb = comb[:len(comb)-1]
		}
	}
	backtrack(1, []int{})
	return res
}