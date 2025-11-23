func letterCombinations(digits string) []string {
	if len(digits) == 0 {
		return []string{}
	}

	phoneMap := map[byte]string{
		'2': "abc",
		'3': "def",
		'4': "ghi",
		'5': "jkl",
		'6': "mno",
		'7': "pqrs",
		'8': "tuv",
		'9': "wxyz",
	}

	result := []string{}
	var backtrack func(index int, currentCombination string)

	backtrack = func(index int, currentCombination string) {
		if index == len(digits) {
			result = append(result, currentCombination)
			return
		}

		digit := digits[index]
		letters := phoneMap[digit]

		for _, char := range letters {
			backtrack(index+1, currentCombination+string(char))
		}
	}

	backtrack(0, "")
	return result
}