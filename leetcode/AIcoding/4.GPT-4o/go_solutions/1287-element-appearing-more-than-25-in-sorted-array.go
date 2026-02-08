func findSpecialInteger(arr []int) int {
    n := len(arr)
    threshold := n / 4
    for i := 0; i < n; i++ {
        if i+threshold < n && arr[i] == arr[i+threshold] {
            return arr[i]
        }
        for i < n-1 && arr[i] == arr[i+1] {
            i++
        }
    }
    return -1
}