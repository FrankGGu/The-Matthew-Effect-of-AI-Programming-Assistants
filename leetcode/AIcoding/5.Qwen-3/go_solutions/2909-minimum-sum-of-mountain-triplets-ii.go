package main

func minSum(arr []int) int {
    n := len(arr)
    if n < 3 {
        return -1
    }

    leftMin := make([]int, n)
    rightMin := make([]int, n)

    leftMin[0] = arr[0]
    for i := 1; i < n; i++ {
        leftMin[i] = min(leftMin[i-1], arr[i])
    }

    rightMin[n-1] = arr[n-1]
    for i := n - 2; i >= 0; i-- {
        rightMin[i] = min(rightMin[i+1], arr[i])
    }

    for i := 1; i < n-1; i++ {
        if leftMin[i] < arr[i] && rightMin[i] < arr[i] {
            return leftMin[i] + arr[i] + rightMin[i]
        }
    }

    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}