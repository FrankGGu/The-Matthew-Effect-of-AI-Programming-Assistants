func maxDepthAfterSplit(seq string) []int {
	ans := make([]int, len(seq))
	depth := 0
	for i, c := range seq {
		if c == '(' {
			depth++
			ans[i] = depth % 2
		} else {
			ans[i] = depth % 2
			depth--
		}
	}
	return ans
}