func addMinimum(word string) int {
	res := 0
	i := 0
	n := len(word)

	for i < n {
		if i < n && word[i] == 'a' {
			i++
		} else {
			res++
		}

		if i < n && word[i] == 'b' {
			i++
		} else {
			res++
		}

		if i < n && word[i] == 'c' {
			i++
		} else {
			res++
		}
	}

	return res
}