func findAnagrams(s string, p string) []int {
    pLen, sLen := len(p), len(s)
    if pLen > sLen {
        return nil
    }

    pCount := make([]int, 26)
    sCount := make([]int, 26)
    for i := 0; i < pLen; i++ {
        pCount[p[i]-'a']++
        sCount[s[i]-'a']++
    }

    result := []int{}
    if pCount == sCount {
        result = append(result, 0)
    }

    for i := pLen; i < sLen; i++ {
        sCount[s[i]-'a']++
        sCount[s[i-pLen]-'a']--
        if sCount == pCount {
            result = append(result, i-pLen+1)
        }
    }

    return result
}