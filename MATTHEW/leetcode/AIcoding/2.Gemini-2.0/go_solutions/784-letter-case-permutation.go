func letterCasePermutation(s string) []string {
	res := []string{}
	var backtrack func(string, int)
	backtrack = func(str string, index int) {
		if index == len(s) {
			res = append(res, str)
			return
		}

		char := s[index]
		if 'a' <= char && char <= 'z' {
			backtrack(str+string(char), index+1)
			backtrack(str+string(char-'a'+'A'), index+1)
		} else if 'A' <= char && char <= 'Z' {
			backtrack(str+string(char), index+1)
			backtrack(str+string(char-'A'+'a'), index+1)
		} else {
			backtrack(str+string(char), index+1)
		}
	}

	backtrack("", 0)
	return res
}