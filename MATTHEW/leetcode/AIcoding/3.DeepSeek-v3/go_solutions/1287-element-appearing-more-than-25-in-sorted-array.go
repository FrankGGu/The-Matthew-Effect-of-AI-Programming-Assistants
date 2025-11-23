func findSpecialInteger(arr []int) int {
    n := len(arr)
    quarter := n / 4
    for i := 0; i < n-quarter; i++ {
        if arr[i] == arr[i+quarter] {
            return arr[i]
        }
    }
    return -1
}