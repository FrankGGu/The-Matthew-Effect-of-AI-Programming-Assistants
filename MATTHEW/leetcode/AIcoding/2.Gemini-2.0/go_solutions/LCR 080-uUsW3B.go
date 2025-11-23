func combine(n int, k int) [][]int {
	result := [][]int{}
	var backtrack func(start int, combination []int)
	backtrack = func(start int, combination []int) {
		if len(combination) == k {
			temp := make([]int, k)
			copy(temp, combination)
			result = append(result, temp)
			return
		}
		for i := start; i <= n; i++ {
			combination = append(combination, i)
			backtrack(i+1, combination)
			combination = combination[:len(combination)-1]
		}
	}
	backtrack(1, []int{})
	return result
}