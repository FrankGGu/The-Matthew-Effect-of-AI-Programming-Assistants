package main

func minTotalCost(arr []int, target int) int {
    n := len(arr)
    left := make([]int, n+1)
    right := make([]int, n+1)

    for i := 0; i < n; i++ {
        left[i+1] = left[i]
        if i > 0 {
            left[i+1] = min(left[i+1], left[i])
        }
        if arr[i] == target {
            left[i+1] = min(left[i+1], i)
        }
    }

    for i := n - 1; i >= 0; i-- {
        right[i] = right[i+1]
        if i < n-1 {
            right[i] = min(right[i], right[i+1])
        }
        if arr[i] == target {
            right[i] = min(right[i], i)
        }
    }

    res := -1
    for i := 0; i < n; i++ {
        if arr[i] == target {
            if i > 0 && left[i] != -1 {
                if res == -1 || (i - left[i]) + (i - left[i]) < res {
                    res = (i - left[i]) + (i - left[i])
                }
            }
            if i < n-1 && right[i+1] != -1 {
                if res == -1 || (right[i+1] - i) + (right[i+1] - i) < res {
                    res = (right[i+1] - i) + (right[i+1] - i)
                }
            }
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}