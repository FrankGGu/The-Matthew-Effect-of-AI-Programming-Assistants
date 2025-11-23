func getHappyString(n int, k int) string {
	count := 0
	result := ""
	var backtrack func(int, string)
	backtrack = func(index int, current string) {
		if index == n {
			count++
			if count == k {
				result = current
			}
			return
		}
		if count >= k {
			return
		}
		for _, c := range []string{"a", "b", "c"} {
			if index > 0 && current[index-1:index] == c {
				continue
			}
			backtrack(index+1, current+c)
		}
	}

	backtrack(0, "")
	return result
}