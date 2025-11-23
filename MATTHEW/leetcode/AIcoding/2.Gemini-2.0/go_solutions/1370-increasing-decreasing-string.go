func sortString(s string) string {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }

    result := []byte{}
    for len(result) < len(s) {
        for i := 0; i < 26; i++ {
            if count[i] > 0 {
                result = append(result, byte('a'+i))
                count[i]--
            }
        }
        for i := 25; i >= 0; i-- {
            if count[i] > 0 {
                result = append(result, byte('a'+i))
                count[i]--
            }
        }
    }

    return string(result)
}