func numWays(s string) int {
    const mod = 1e9 + 7
    count := 0
    for _, ch := range s {
        if ch == '1' {
            count++
        }
    }
    if count % 3 != 0 {
        return 0
    }
    if count == 0 {
        n := len(s)
        return (n - 1) * (n - 2) / 2 % mod
    }
    target := count / 3
    firstEnd, secondStart := 0, 0
    current := 0
    for i, ch := range s {
        if ch == '1' {
            current++
        }
        if current == target {
            firstEnd++
        } else if current == 2 * target {
            secondStart++
        }
    }
    return firstEnd * secondStart % mod
}