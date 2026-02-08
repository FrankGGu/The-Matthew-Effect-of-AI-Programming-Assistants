package main

func getLastMoment(n int, left []int, right []int) int {
    maxLeft := 0
    for _, l := range left {
        if l > maxLeft {
            maxLeft = l
        }
    }
    minRight := n
    for _, r := range right {
        if r < minRight {
            minRight = r
        }
    }
    return max(maxLeft, n-minRight)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}