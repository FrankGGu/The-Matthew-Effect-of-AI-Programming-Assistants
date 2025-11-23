func findAnagrams(s string, p string) []int {
    sLen, pLen := len(s), len(p)
    if sLen < pLen {
        return []int{}
    }

    pCount := make([]int, 26)
    sCount := make([]int, 26)

    for _, char := range p {
        pCount[char-'a']++
    }

    for i := 0; i < pLen; i++ {
        sCount[s[i]-'a']++
    }

    result := []int{}
    if sCount == pCount {
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