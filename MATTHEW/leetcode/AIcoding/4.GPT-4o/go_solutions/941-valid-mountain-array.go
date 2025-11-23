func validMountainArray(arr []int) bool {
    n := len(arr)
    if n < 3 {
        return false
    }

    i := 0
    for i < n-1 && arr[i] < arr[i+1] {
        i++
    }

    if i == 0 || i == n-1 {
        return false
    }

    for i < n-1 && arr[i] > arr[i+1] {
        i++
    }

    return i == n-1
}