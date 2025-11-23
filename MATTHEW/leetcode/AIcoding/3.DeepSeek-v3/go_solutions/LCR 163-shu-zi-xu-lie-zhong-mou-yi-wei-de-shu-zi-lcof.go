func findKthNumber(n int, k int) int {
    current := 1
    k--
    for k > 0 {
        steps := calcSteps(n, current, current+1)
        if steps <= k {
            current++
            k -= steps
        } else {
            current *= 10
            k--
        }
    }
    return current
}

func calcSteps(n int, n1 int, n2 int) int {
    steps := 0
    for n1 <= n {
        steps += min(n2, n+1) - n1
        n1 *= 10
        n2 *= 10
    }
    return steps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}