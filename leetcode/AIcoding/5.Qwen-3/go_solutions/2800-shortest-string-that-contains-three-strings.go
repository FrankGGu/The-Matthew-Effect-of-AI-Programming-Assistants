package main

func minimumString(a, b, c string) string {
    var combine func(string, string) string
    combine = func(s, t string) string {
        if len(s) > len(t) {
            s, t = t, s
        }
        for i := len(s); i >= 0; i-- {
            if len(t) >= i && s[:i] == t[len(t)-i:] {
                return t + s[i:]
            }
        }
        return t + s
    }

    var res string
    for _, perm := range [][3]string{{a, b, c}, {a, c, b}, {b, a, c}, {b, c, a}, {c, a, b}, {c, b, a}} {
        temp := combine(combine(perm[0], perm[1]), perm[2])
        if res == "" || len(temp) < len(res) || (len(temp) == len(res) && temp < res) {
            res = temp
        }
    }
    return res
}