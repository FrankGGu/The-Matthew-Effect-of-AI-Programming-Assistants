package main

func minimumRecolors(s string, k int) int {
    minRecolors := k
    count := 0

    for i := 0; i < k; i++ {
        if s[i] == 'b' {
            count++
        }
    }

    minRecolors = k - count

    for i := k; i < len(s); i++ {
        if s[i] == 'b' {
            count++
        }
        if s[i-k] == 'b' {
            count--
        }
        minRecolors = min(minRecolors, k-count)
    }

    return minRecolors
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}