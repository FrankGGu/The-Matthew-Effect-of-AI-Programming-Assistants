func transformArray(arr []int) []int {
    n := len(arr)
    result := make([]int, n)

    for i := 0; i < n; i++ {
        result[i] = arr[i]
    }

    for {
        changed := false
        for i := 1; i < n-1; i++ {
            if arr[i-1] < arr[i] && arr[i] > arr[i+1] {
                result[i]--
                changed = true
            } else if arr[i-1] > arr[i] && arr[i] < arr[i+1] {
                result[i]++
                changed = true
            }
        }

        if !changed {
            break
        }

        for i := 0; i < n; i++ {
            arr[i] = result[i]
        }
    }

    return result
}