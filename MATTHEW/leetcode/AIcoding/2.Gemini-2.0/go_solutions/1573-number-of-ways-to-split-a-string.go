func numWays(s string) int {
    n := len(s)
    ones := 0
    for i := 0; i < n; i++ {
        if s[i] == '1' {
            ones++
        }
    }
    if ones%3 != 0 {
        return 0
    }
    if ones == 0 {
        return (n - 1) * (n - 2) / 2 % 1000000007
    }
    target := ones / 3
    firstCut := 0
    secondCut := 0
    count := 0
    for i := 0; i < n; i++ {
        if s[i] == '1' {
            count++
        }
        if count == target {
            firstCut++
        }
        if count == 2*target {
            secondCut++
        }
    }
    return (firstCut * secondCut) % 1000000007
}