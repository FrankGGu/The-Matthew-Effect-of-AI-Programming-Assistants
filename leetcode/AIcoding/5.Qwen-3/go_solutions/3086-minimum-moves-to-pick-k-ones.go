package main

func minMoves(nums []int, k int) int {
    if k == 1 {
        return 0
    }
    var ones []int
    for i, num := range nums {
        if num == 1 {
            ones = append(ones, i)
        }
    }
    n := len(ones)
    res := int(^uint(0) >> 1)
    for i := 0; i <= n-k; i++ {
        left := i
        right := i + k - 1
        mid := i + (k-1)/2
        total := 0
        for j := left; j <= right; j++ {
            total += abs(ones[j] - ones[mid])
        }
        res = min(res, total)
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}