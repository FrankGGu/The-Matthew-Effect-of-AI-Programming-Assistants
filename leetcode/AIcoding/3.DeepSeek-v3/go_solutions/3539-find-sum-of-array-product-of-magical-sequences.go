func sumOfArrayProduct(nums []int) int {
    const mod = 1e9 + 7
    n := len(nums)
    if n == 0 {
        return 0
    }

    prefix := make([]int, n)
    suffix := make([]int, n)

    prefix[0] = nums[0]
    for i := 1; i < n; i++ {
        prefix[i] = (prefix[i-1] * nums[i]) % mod
    }

    suffix[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        suffix[i] = (suffix[i+1] * nums[i]) % mod
    }

    res := 0
    for i := 0; i < n; i++ {
        if i == 0 {
            res = (res + suffix[i+1]) % mod
        } else if i == n-1 {
            res = (res + prefix[i-1]) % mod
        } else {
            res = (res + prefix[i-1] * suffix[i+1]) % mod
        }
    }

    return res
}