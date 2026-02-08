func strWithout3a3b(a int, b int) string {
    res := ""
    for a > 0 || b > 0 {
        if a > b {
            if len(res) >= 2 && res[len(res)-1] == 'a' && res[len(res)-2] == 'a' {
                if b > 0 {
                    res += "b"
                    b--
                } else {
                    break
                }
            } else {
                res += "a"
                a--
            }
        } else if b > a {
            if len(res) >= 2 && res[len(res)-1] == 'b' && res[len(res)-2] == 'b' {
                if a > 0 {
                    res += "a"
                    a--
                } else {
                    break
                }
            } else {
                res += "b"
                b--
            }
        } else {
            if len(res) >= 1 && res[len(res)-1] == 'a' {
                res += "b"
                b--
            } else {
                res += "a"
                a--
            }
        }
    }
    return res
}