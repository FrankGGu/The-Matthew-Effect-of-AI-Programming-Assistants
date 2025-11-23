func rotate(nums []int, k int) {
    n := len(nums)
    if n == 0 {
        return
    }

    k %= n

    reverse := func(arr []int, start, end int) {
        for start < end {
            arr[start], arr[end] = arr[end], arr[start]
            start++
            end--
        }
    }

    reverse(nums, 0, n-k-1)
    reverse(nums, n-k, n-1)
    reverse(nums, 0, n-1)
}