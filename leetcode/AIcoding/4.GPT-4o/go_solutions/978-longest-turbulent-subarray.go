func maxTurbulenceSize(arr []int) int {
    n := len(arr)
    if n < 2 {
        return n
    }

    maxLength := 1
    currentLength := 1
    for i := 1; i < n; i++ {
        if (arr[i] > arr[i-1] && (i == 1 || arr[i-1] <= arr[i-2])) || 
            (arr[i] < arr[i-1] && (i == 1 || arr[i-1] >= arr[i-2]))) {
            currentLength++
        } else {
            currentLength = 2
        }
        maxLength = max(maxLength, currentLength)
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}