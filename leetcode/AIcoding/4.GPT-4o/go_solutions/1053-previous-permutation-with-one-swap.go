func prevPermOpt1(arr []int) []int {
    n := len(arr)
    if n <= 1 {
        return arr
    }

    i := n - 2
    for i >= 0 && arr[i] <= arr[i+1] {
        i--
    }

    if i < 0 {
        return arr
    }

    j := n - 1
    for arr[j] >= arr[i] {
        j--
    }

    for k := n - 1; k > i; k-- {
        if arr[k] < arr[i] && arr[k] != arr[k-1] {
            j = k
            break
        }
    }

    arr[i], arr[j] = arr[j], arr[i]
    return arr
}