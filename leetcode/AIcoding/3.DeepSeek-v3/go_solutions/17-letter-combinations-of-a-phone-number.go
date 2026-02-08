func letterCombinations(digits string) []string {
    if len(digits) == 0 {
        return []string{}
    }

    digitToLetters := map[byte]string{
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
    backtrack(digits, 0, "", digitToLetters, &result)
    return result
}

func backtrack(digits string, index int, current string, digitToLetters map[byte]string, result *[]string) {
    if index == len(digits) {
        *result = append(*result, current)
        return
    }

    letters := digitToLetters[digits[index]]
    for i := 0; i < len(letters); i++ {
        backtrack(digits, index+1, current+string(letters[i]), digitToLetters, result)
    }
}