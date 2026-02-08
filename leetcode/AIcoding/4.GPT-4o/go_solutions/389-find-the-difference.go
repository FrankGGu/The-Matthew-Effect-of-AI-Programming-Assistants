func findTheDifference(s string, t string) byte {
    var count [26]int
    for _, ch := range s {
        count[ch-'a']++
    }
    for _, ch := range t {
        count[ch-'a']--
        if count[ch-'a'] < 0 {
            return byte(ch)
        }
    }
    return 0
}