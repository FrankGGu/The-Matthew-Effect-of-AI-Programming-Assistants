func restoreIpAddresses(s string) []string {
    var res []string
    var path []string
    var backtrack func(start int)

    backtrack = func(start int) {
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
                backtrack(i+1)
                path = path[:len(path)-1]
            }
        }
    }

    backtrack(0)
    return res
}

func isValid(segment string) bool {
    if len(segment) > 1 && segment[0] == '0' {
        return false
    }
    num, _ := strconv.Atoi(segment)
    return num >= 0 && num <= 255
}