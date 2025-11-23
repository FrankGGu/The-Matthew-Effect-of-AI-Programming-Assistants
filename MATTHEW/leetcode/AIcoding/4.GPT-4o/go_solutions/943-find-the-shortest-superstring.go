package main

import "fmt"

func findShortestSuperstring(A []string) string {
    n := len(A)
    if n == 0 {
        return ""
    }

    overlap := func(a, b string) int {
        maxOverlap := 0
        for i := 1; i <= len(a); i++ {
            if len(b) < i {
                continue
            }
            if a[len(a)-i:] == b[:i] {
                maxOverlap = i
            }
        }
        return maxOverlap
    }

    dp := make([][]int, 1<<n)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    for i := 0; i < n; i++ {
        dp[1<<i][i] = len(A[i])
    }

    for mask := 1; mask < (1 << n); mask++ {
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 {
                continue
            }
            for j := 0; j < n; j++ {
                if mask&(1<<j) != 0 {
                    continue
                }
                newMask := mask | (1 << j)
                dp[newMask][j] = max(dp[newMask][j], dp[mask][i]+len(A[j])-overlap(A[i], A[j]))
            }
        }
    }

    maxLen := 0
    lastIndex := -1
    for i := 0; i < n; i++ {
        if dp[(1<<n)-1][i] > maxLen {
            maxLen = dp[(1<<n)-1][i]
            lastIndex = i
        }
    }

    if maxLen == 0 {
        return ""
    }

    order := make([]int, 0)
    mask := (1 << n) - 1
    for mask > 0 {
        order = append(order, lastIndex)
        nextMask := mask ^ (1 << lastIndex)
        for i := 0; i < n; i++ {
            if nextMask&(1<<i) > 0 && dp[mask][lastIndex] == dp[nextMask][i]+len(A[lastIndex])-overlap(A[i], A[lastIndex]) {
                lastIndex = i
                break
            }
        }
        mask = nextMask
    }

    reverse(order)
    result := A[order[0]]
    for i := 1; i < len(order); i++ {
        result += A[order[i]][overlap(A[order[i-1]], A[order[i]]):]
    }

    return result
}

func reverse(s []int) {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        s[i], s[j] = s[j], s[i]
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    A := []string{"catg", "ctaagt", "gcta", "ttca", "atgcatc"}
    fmt.Println(findShortestSuperstring(A))
}