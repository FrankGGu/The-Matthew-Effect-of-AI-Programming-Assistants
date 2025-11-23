func addOperators(num string, target int) []string {
    var res []string
    var dfs func(string, string, int, int)
    dfs = func(path string, numStr string, eval, prev int) {
        if len(numStr) == 0 {
            if eval == target {
                res = append(res, path)
            }
            return
        }
        for i := 1; i <= len(numStr); i++ {
            if i > 1 && numStr[0] == '0' {
                break
            }
            currStr := numStr[:i]
            curr, _ := strconv.Atoi(currStr)
            if len(path) == 0 {
                dfs(currStr, numStr[i:], curr, curr)
            } else {
                dfs(path+"+"+currStr, numStr[i:], eval+curr, curr)
                dfs(path+"-"+currStr, numStr[i:], eval-curr, -curr)
                dfs(path+"*"+currStr, numStr[i:], eval-prev+prev*curr, prev*curr)
            }
        }
    }
    dfs("", num, 0, 0)
    return res
}