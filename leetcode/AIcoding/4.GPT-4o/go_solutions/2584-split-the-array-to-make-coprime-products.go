func findValidSplit(nums []int) bool {
    n := len(nums)
    if n == 1 {
        return true
    }

    gcd := func(a, b int) int {
        for b != 0 {
            a, b = b, a%b
        }
        return a
    }

    valid := make([]bool, n)
    valid[0] = true
    g := nums[0]

    for i := 1; i < n; i++ {
        g = gcd(g, nums[i])
        if g == 1 {
            valid[i] = true
        }
    }

    for i := 1; i < n; i++ {
        if valid[i-1] && gcd(nums[i-1], nums[i]) == 1 {
            return true
        }
    }

    return valid[n-1]
}