func movesToStamp(stamp string, target string) []int {
    s, t := []byte(stamp), []byte(target)
    slen, tlen := len(s), len(t)
    res := make([]int, 0)
    visited := make([]bool, tlen)
    var stars int

    for stars < tlen {
        var replaced bool
        for i := 0; i <= tlen - slen; i++ {
            if !visited[i] && canReplace(t, i, s) {
                stars = replace(t, i, slen, stars)
                replaced = true
                visited[i] = true
                res = append(res, i)
                if stars == tlen {
                    break
                }
            }
        }
        if !replaced {
            return []int{}
        }
    }

    reverse(res)
    return res
}

func canReplace(t []byte, pos int, s []byte) bool {
    for i := 0; i < len(s); i++ {
        if t[pos + i] != '*' && t[pos + i] != s[i] {
            return false
        }
    }
    return true
}

func replace(t []byte, pos int, slen int, stars int) int {
    for i := 0; i < slen; i++ {
        if t[pos + i] != '*' {
            t[pos + i] = '*'
            stars++
        }
    }
    return stars
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}