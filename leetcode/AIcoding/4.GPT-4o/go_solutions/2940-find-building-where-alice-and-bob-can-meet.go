func findBuilding(arr []int) int {
    n := len(arr)
    if n == 0 {
        return -1
    }

    left := make([]int, n)
    right := make([]int, n)

    left[0] = arr[0]
    for i := 1; i < n; i++ {
        left[i] = max(left[i-1], arr[i])
    }

    right[n-1] = arr[n-1]
    for i := n - 2; i >= 0; i-- {
        right[i] = max(right[i+1], arr[i])
    }

    minBuilding := -1
    for i := 0; i < n; i++ {
        if arr[i] >= left[i] && arr[i] >= right[i] {
            if minBuilding == -1 || arr[i] < arr[minBuilding] {
                minBuilding = i
            }
        }
    }

    return minBuilding + 1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}