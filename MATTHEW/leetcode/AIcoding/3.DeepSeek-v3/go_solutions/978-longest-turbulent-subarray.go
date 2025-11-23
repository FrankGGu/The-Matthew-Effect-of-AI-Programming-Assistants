func maxTurbulenceSize(arr []int) int {
    n := len(arr)
    if n < 2 {
        return n
    }
    res := 1
    inc, dec := 1, 1
    for i := 1; i < n; i++ {
        if arr[i] > arr[i-1] {
            inc = dec + 1
            dec = 1
        } else if arr[i] < arr[i-1] {
            dec = inc + 1
            inc = 1
        } else {
            inc, dec = 1, 1
        }
        if inc > res {
            res = inc
        }
        if dec > res {
            res = dec
        }
    }
    return res
}