package main

func getPermutation(n int, k int) string {
    nums := make([]int, n)
    for i := 0; i < n; i++ {
        nums[i] = i + 1
    }

    factorial := make([]int, n)
    factorial[0] = 1
    for i := 1; i < n; i++ {
        factorial[i] = factorial[i-1] * i
    }

    k--
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        index := k / factorial[n-1-i]
        result[i] = byte('0' + nums[index])
        nums = append(nums[:index], nums[index+1:]...)
        k = k % factorial[n-1-i]
    }

    return string(result)
}