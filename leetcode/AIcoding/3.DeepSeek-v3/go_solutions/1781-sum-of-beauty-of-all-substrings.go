func beautySum(s string) int {
    res := 0
    for i := 0; i < len(s); i++ {
        freq := [26]int{}
        for j := i; j < len(s); j++ {
            freq[s[j]-'a']++
            maxFreq, minFreq := 0, len(s)
            for _, cnt := range freq {
                if cnt > 0 {
                    if cnt > maxFreq {
                        maxFreq = cnt
                    }
                    if cnt < minFreq {
                        minFreq = cnt
                    }
                }
            }
            res += maxFreq - minFreq
        }
    }
    return res
}