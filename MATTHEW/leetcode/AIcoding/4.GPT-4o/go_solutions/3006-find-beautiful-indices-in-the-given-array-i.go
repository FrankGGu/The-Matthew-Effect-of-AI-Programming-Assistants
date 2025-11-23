func beautifulIndices(arr []int) []int {
    n := len(arr)
    result := []int{}
    for i := 0; i < n; i++ {
        if (i == 0 || arr[i] > arr[i-1]) && (i == n-1 || arr[i] > arr[i+1]) {
            result = append(result, i)
        }
    }
    return result
}