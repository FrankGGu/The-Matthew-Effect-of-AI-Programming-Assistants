func findLengthOfShortestSubarray(arr []int) int {
    n := len(arr)
    left, right := 0, n-1

    for left < n-1 && arr[left] <= arr[left+1] {
        left++
    }
    if left == n-1 {
        return 0
    }

    for right > 0 && arr[right] >= arr[right-1] {
        right--
    }

    res := min(n-left-1, right)

    i, j := 0, right
    for i <= left && j < n {
        if arr[i] <= arr[j] {
            res = min(res, j-i-1)
            i++
        } else {
            j++
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