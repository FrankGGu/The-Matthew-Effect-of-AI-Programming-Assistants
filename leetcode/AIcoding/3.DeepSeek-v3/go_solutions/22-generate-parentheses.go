func generateParenthesis(n int) []string {
    var res []string
    backtrack(&res, "", 0, 0, n)
    return res
}

func backtrack(res *[]string, current string, open, close, max int) {
    if len(current) == max*2 {
        *res = append(*res, current)
        return
    }

    if open < max {
        backtrack(res, current+"(", open+1, close, max)
    }
    if close < open {
        backtrack(res, current+")", open, close+1, max)
    }
}