package main

func letterCasePermutation(s string) []string {
    result := []string{""}
    for _, char := range s {
        if '0' <= char && char <= '9' {
            for i := range result {
                result[i] += string(char)
            }
        } else {
            temp := []string{}
            for _, prefix := range result {
                temp = append(temp, prefix+string(char))
                temp = append(temp, prefix+string(rune(char^32)))
            }
            result = temp
        }
    }
    return result
}