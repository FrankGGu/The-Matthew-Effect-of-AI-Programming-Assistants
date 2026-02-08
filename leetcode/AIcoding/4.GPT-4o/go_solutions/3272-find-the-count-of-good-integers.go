func countGoodIntegers(n int) int {
    count := 0
    for i := 1; i <= n; i++ {
        s := strconv.Itoa(i)
        if strings.Contains(s, "0") {
            continue
        }
        allSame := true
        for j := 1; j < len(s); j++ {
            if s[j] != s[0] {
                allSame = false
                break
            }
        }
        if allSame {
            count++
        }
    }
    return count
}