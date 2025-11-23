func maxDepthAfterSplit(s string) []int {
	ans := make([]int, len(s))
	depth := 0
	for i, char := range s {
		if char == '(' {
			depth++
			ans[i] = depth % 2
		} else { // char == ')'
			ans[i] = depth % 2
			depth--
		}
	}
	return ans
}