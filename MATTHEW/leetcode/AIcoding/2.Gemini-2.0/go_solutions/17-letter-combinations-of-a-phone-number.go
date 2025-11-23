var phoneMap = map[string]string{
	"2": "abc",
	"3": "def",
	"4": "ghi",
	"5": "jkl",
	"6": "mno",
	"7": "pqrs",
	"8": "tuv",
	"9": "wxyz",
}

func letterCombinations(digits string) []string {
	if len(digits) == 0 {
		return []string{}
	}

	result := []string{}
	var backtrack func(combination string, nextDigits string)

	backtrack = func(combination string, nextDigits string) {
		if len(nextDigits) == 0 {
			result = append(result, combination)
			return
		}

		digit := string(nextDigits[0])
		letters := phoneMap[digit]
		for i := 0; i < len(letters); i++ {
			letter := string(letters[i])
			backtrack(combination+letter, nextDigits[1:])
		}
	}

	backtrack("", digits)
	return result
}