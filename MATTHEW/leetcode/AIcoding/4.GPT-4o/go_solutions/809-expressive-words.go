func expressiveWords(S string, words []string) int {
    var count func(s string) [][]int
    count = func(s string) [][]int {
        res := [][]int{}
        i, n := 0, len(s)
        for i < n {
            j := i
            for j < n && s[j] == s[i] {
                j++
            }
            res = append(res, []int{int(s[i]), j - i})
            i = j
        }
        return res
    }

    base := count(S)
    result := 0

    for _, word := range words {
        wbase := count(word)
        if len(wbase) != len(base) {
            continue
        }
        valid := true
        for i := range base {
            if base[i][0] != wbase[i][0] || (base[i][1] < wbase[i][1]) || (base[i][1] < 3 && base[i][1] != wbase[i][1]) {
                valid = false
                break
            }
        }
        if valid {
            result++
        }
    }
    return result
}