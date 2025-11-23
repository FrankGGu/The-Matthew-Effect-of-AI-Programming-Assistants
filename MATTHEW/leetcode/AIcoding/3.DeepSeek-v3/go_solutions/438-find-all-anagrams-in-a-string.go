func findAnagrams(s string, p string) []int {
    if len(s) < len(p) {
        return []int{}
    }

    pCount := [26]int{}
    sCount := [26]int{}
    for i := 0; i < len(p); i++ {
        pCount[p[i]-'a']++
        sCount[s[i]-'a']++
    }

    res := []int{}
    if pCount == sCount {
        res = append(res, 0)
    }

    for i := len(p); i < len(s); i++ {
        sCount[s[i-len(p)]-'a']--
        sCount[s[i]-'a']++
        if pCount == sCount {
            res = append(res, i-len(p)+1)
        }
    }

    return res
}