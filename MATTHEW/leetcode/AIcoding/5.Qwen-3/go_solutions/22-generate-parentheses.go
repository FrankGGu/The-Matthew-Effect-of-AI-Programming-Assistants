package main

func generateParenthesis(n int) []string {
    result := make([]string, 0)
    backtrack(&result, "", 0, 0, n)
    return result
}

func backtrack(result *[]string, current string, openCount, closeCount, n int) {
    if len(current) == 2*n {
        *result = append(*result, current)
        return
    }
    if openCount < n {
        backtrack(result, current+"(", openCount+1, closeCount, n)
    }
    if closeCount < openCount {
        backtrack(result, current+")", openCount, closeCount+1, n)
    }
}