func letterCombinations(digits string) []string {
    if len(digits) == 0 {
        return []string{}
    }

    phone := map[rune]string{
        '2': "abc",
        '3': "def",
        '4': "ghi",
        '5': "jkl",
        '6': "mno",
        '7': "pqrs",
        '8': "tuv",
        '9': "wxyz",
    }

    var combinations []string
    var backtrack func(index int, path string)
    backtrack = func(index int, path string) {
        if index == len(digits) {
            combinations = append(combinations, path)
            return
        }
        letters := phone[rune(digits[index])]
        for _, letter := range letters {
            backtrack(index+1, path+string(letter))
        }
    }

    backtrack(0, "")
    return combinations
}