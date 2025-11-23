func largeGroupPositions(s string) [][]int {
	result := [][]int{}
	start := 0
	for i := 0; i < len(s); i++ {
		if i == len(s)-1 || s[i] != s[i+1] {
			if i-start+1 >= 3 {
				result = append(result, []int{start, i})
			}
			start = i + 1
		}
	}
	return result
}