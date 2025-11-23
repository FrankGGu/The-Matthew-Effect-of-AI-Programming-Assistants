package main

func maxSubstring(s string, t string, maxCost int) int {
    n := len(s)
    m := len(t)
    if n != m {
        return 0
    }
    maxLen := 0
    left := 0
    currentCost := 0
    for right := 0; right < n; right++ {
        currentCost += abs(int(s[right]) - int(t[right]))
        for currentCost > maxCost {
            currentCost -= abs(int(s[left]) - int(t[left]))
            left++
        }
        maxLen = max(maxLen, right-left+1)
    }
    return maxLen
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}