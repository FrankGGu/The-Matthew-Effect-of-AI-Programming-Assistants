package main

func validStrings(n int) []string {
    var result []string
    var backtrack func(string, int)
    backtrack = func(s string, count int) {
        if len(s) == n {
            result = append(result, s)
            return
        }
        if count < 1 {
            backtrack(s+"0", 0)
        }
        backtrack(s+"1", 1)
    }
    backtrack("", 0)
    return result
}