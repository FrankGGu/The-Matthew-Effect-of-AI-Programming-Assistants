func getPermutation(n int, k int) string {
    factorial := make([]int, n+1)
    for i := 1; i <= n; i++ {
        factorial[i] = factorial[i-1] * i
    }

    nums := make([]int, n)
    for i := 1; i <= n; i++ {
        nums[i-1] = i
    }

    k-- // convert k to zero-based index
    result := ""

    for i := 1; i <= n; i++ {
        idx := k / factorial[n-i]
        result += strconv.Itoa(nums[idx])
        nums = append(nums[:idx], nums[idx+1:]...) // remove used number
        k %= factorial[n-i]
    }

    return result
}