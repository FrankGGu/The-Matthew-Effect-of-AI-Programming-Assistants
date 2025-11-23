func dfs(node int, graph map[int][]int, path []int, palindromes map[string]bool) {
	path = append(path, node)
	str := ""
	for _, n := range path {
		str += string(rune('a' + n))
	}

	isPalindrome := true
	for i := 0; i < len(str)/2; i++ {
		if str[i] != str[len(str)-1-i] {
			isPalindrome = false;
			break
		}
	}
	if isPalindrome {
		palindromes[str] = true
	}

	for _, neighbor := range graph[node] {
		dfs(neighbor, graph, append([]int{}, path...), palindromes)
	}
}

func solve() int {
	n := 5
	graph := map[int][]int{
		0: {1, 2},
		1: {3},
		2: {4},
		3: {},
		4: {},
	}
	palindromes := map[string]bool{}

	for i := 0; i < n; i++ {
		dfs(i, graph, []int{}, palindromes)
	}

	return len(palindromes)
}