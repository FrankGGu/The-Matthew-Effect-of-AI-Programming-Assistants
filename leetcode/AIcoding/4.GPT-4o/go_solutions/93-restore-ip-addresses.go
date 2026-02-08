func restoreIpAddresses(s string) []string {
    var res []string
    var backtrack func(start int, path []string)

    backtrack = func(start int, path []string) {
        if len(path) == 4 {
            if start == len(s) {
                res = append(res, strings.Join(path, "."))
            }
            return
        }

        for i := 1; i <= 3; i++ {
            if start+i > len(s) {
                break
            }
            segment := s[start:start+i]
            if (segment[0] == '0' && len(segment) > 1) || (i == 3 && segment > "255") {
                continue
            }
            backtrack(start+i, append(path, segment))
        }
    }

    backtrack(0, []string{})
    return res
}