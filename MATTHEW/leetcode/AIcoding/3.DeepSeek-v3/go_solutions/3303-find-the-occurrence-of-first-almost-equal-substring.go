func findFirstAlmostEqualSubstring(s string, t string, maxCost int) int {
    n := len(s)
    m := len(t)
    if n < m {
        return -1
    }

    cost := make([]int, n)
    for i := 0; i < n; i++ {
        if i >= m {
            break
        }
        cost[i] = abs(int(s[i]) - int(t[i]))
    }

    left := 0
    currentCost := 0
    minLen := n + 1
    result := -1

    for right := 0; right < n; right++ {
        currentCost += cost[right]

        for currentCost > maxCost {
            currentCost -= cost[left]
            left++
        }

        if right - left + 1 == m {
            if left < minLen {
                minLen = left
                result = left
            }
        }
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}