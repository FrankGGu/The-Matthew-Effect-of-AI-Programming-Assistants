package main

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}

func maxTurbulenceSize(arr []int) int {
    n := len(arr)
    if n <= 1 {
        return n
    }
    maxLen := 1
    start := 0
    for i := 1; i < n; i++ {
        if arr[i] == arr[i-1] {
            start = i
        } else if i == 1 || (arr[i] > arr[i-1] && arr[i-1] < arr[i-2]) || (arr[i] < arr[i-1] && arr[i-1] > arr[i-2]) {
            maxLen = max(maxLen, i - start + 1)
        } else {
            start = i - 1
        }
    }
    return maxLen
}