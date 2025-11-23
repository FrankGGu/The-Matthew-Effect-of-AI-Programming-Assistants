func restoreIpAddresses(s string) []string {
    var res []string
    var path []string
    var dfs func(int)

    dfs = func(start int) {
        if len(path) == 4 {
            if start == len(s) {
                res = append(res, strings.Join(path, "."))
            }
            return
        }

        for i := start; i < len(s) && i < start+3; i++ {
            segment := s[start:i+1]
            if isValid(segment) {
                path = append(path, segment)
                dfs(i+1)
                path = path[:len(path)-1]
            }
        }
    }

    dfs(0)
    return res
}

func isValid(segment string) bool {
    if len(segment) > 1 && segment[0] == '0' {
        return false
    }
    num, _ := strconv.Atoi(segment)
    return num >= 0 && num <= 255
}