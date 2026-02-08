package main

func countSteppingNumbers(s string, e string) int {
    var result int
    var dfs func(start bool, prevDigit byte, current string)
    dfs = func(start bool, prevDigit byte, current string) {
        if len(current) > 0 {
            num, _ := strconv.Atoi(current)
            if num >= s && num <= e {
                result++
            }
        }
        if len(current) == len(e) {
            return
        }
        for d := byte('0'); d <= '9'; d++ {
            if start || (d == prevDigit+1 || d == prevDigit-1) {
                dfs(false, d, current+string(d))
            }
        }
    }
    dfs(true, -1, "")
    return result
}