func splitIntoFibonacci(s string) []int {
	path := []int{}
	if backtrack(s, 0, &path) {
		return path
	}
	return []int{}
}

func backtrack(s string, start int, path