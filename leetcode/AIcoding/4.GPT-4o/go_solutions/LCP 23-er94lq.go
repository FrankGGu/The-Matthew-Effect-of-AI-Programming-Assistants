func getPermutation(n int, k int) string {
    factorial := make([]int, n+1)
    for i := 1; i <= n; i++ {
        factorial[i] = factorial[i-1] * i
    }

    nums := make([]int, n)
    for i := 1; i <= n; i++ {
        nums[i-1] = i
    }

    k-- // 转换为0-indexed
    result := []byte{}

    for i := 1; i <= n; i++ {
        idx := k / factorial[n-i]
        result = append(result, byte(nums[idx]+'0'))
        nums = append(nums[:idx], nums[idx+1:]...)
        k %= factorial[n-i]
    }

    return string(result)
}