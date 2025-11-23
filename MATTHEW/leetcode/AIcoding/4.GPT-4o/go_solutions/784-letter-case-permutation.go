func letterCasePermutation(s string) []string {
    result := []string{}
    var backtrack func(path string, index int)

    backtrack = func(path string, index int) {
        if index == len(s) {
            result = append(result, path)
            return
        }

        if s[index] >= '0' && s[index] <= '9' {
            backtrack(path+s[index:index+1], index+1)
        } else {
            backtrack(path+string(s[index]), index+1)
            if s[index] >= 'a' && s[index] <= 'z' {
                backtrack(path+string(s[index]-32), index+1)
            } else {
                backtrack(path+string(s[index]+32), index+1)
            }
        }
    }

    backtrack("", 0)
    return result
}