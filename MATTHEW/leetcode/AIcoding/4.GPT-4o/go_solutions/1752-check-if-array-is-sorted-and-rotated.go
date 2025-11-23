func check(arr []int) bool {
    n := len(arr)
    count := 0
    for i := 0; i < n; i++ {
        if arr[i] > arr[(i+1)%n] {
            count++
        }
    }
    return count <= 1
}