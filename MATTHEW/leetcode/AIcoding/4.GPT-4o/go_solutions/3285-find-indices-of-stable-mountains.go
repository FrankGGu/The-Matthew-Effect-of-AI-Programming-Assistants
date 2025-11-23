func findStableMountains(arr []int) []int {
    n := len(arr)
    if n < 3 {
        return []int{}
    }
    result := []int{}
    for i := 1; i < n-1; i++ {
        if arr[i-1] < arr[i] && arr[i] > arr[i+1] {
            result = append(result, i)
        }
    }
    return result
}