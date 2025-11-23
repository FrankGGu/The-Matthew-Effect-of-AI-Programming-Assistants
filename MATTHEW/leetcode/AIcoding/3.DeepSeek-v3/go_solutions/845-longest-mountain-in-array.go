func longestMountain(arr []int) int {
    n := len(arr)
    if n < 3 {
        return 0
    }
    res := 0
    for i := 1; i < n-1; {
        if arr[i] > arr[i-1] && arr[i] > arr[i+1] {
            left := i - 1
            for left > 0 && arr[left] > arr[left-1] {
                left--
            }
            right := i + 1
            for right < n-1 && arr[right] > arr[right+1] {
                right++
            }
            if right-left+1 > res {
                res = right - left + 1
            }
            i = right + 1
        } else {
            i++
        }
    }
    return res
}