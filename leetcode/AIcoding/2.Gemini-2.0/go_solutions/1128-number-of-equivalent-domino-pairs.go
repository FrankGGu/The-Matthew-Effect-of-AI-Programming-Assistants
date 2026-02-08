func numEquivDominoPairs(dominoes [][]int) int {
	count := make(map[[2]int]int)
	res := 0
	for _, domino := range dominoes {
		a, b := domino[0], domino[1]
		if a > b {
			a, b = b, a
		}
		pair := [2]int{a, b}
		res += count[pair]
		count[pair]++
	}
	return res
}