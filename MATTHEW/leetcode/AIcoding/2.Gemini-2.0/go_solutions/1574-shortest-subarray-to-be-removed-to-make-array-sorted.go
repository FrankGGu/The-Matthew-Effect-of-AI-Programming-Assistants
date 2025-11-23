func findLengthOfShortestSubarray(arr []int) int {
    n := len(arr)
    l, r := 0, n-1
    for l < n-1 && arr[l] <= arr[l+1] {
        l++
    }
    if l == n-1 {
        return 0
    }
    for r > 0 && arr[r] >= arr[r-1] {
        r--
    }
    ans := min(n-l-1, r)
    i, j := 0, r
    for i <= l && j < n {
        if arr[i] <= arr[j] {
            ans = min(ans, j-i-1)
            i++
        } else {
            j++
        }
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}