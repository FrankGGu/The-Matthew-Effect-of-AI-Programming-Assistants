package main

func letterCombinations(digits string) []string {
	if len(digits) == 0 {
		return nil
	}

	mapping := map[byte]string{
		'2': "abc",
		'3': "def",
		'4': "ghi",
		'5': "jkl",
		'6': "mno",
		'7': "pqrs",
		'8': "tuv",
		'9': "wxyz",
	}

	var result []string
	result = append(result, "")

	for i := 0; i < len(digits); i++ {
		digit := digits[i]
		letters := mapping[digit]
		var newResult []string
		for _, s := range result {
			for j := 0; j < len(letters); j++ {
				newResult = append(newResult, s+string(letters[j]))
			}
		}
		result = newResult
	}

	return result
}