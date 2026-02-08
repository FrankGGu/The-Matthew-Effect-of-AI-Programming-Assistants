func findValidStartPoints(nums []int) []int {
    n := len(nums)
    if n == 0 {
        return nil
    }

    gcd := make([][]int, n)
    for i := 0; i < n; i++ {
        gcd[i] = make([]int, n)
        gcd[i][i] = nums[i]
    }

    for length := 2; length <= n; length++ {
        for start := 0; start <= n-length; start++ {
            end := start + length - 1
            gcd[start][end] = gcd(gcd[start][end-1], nums[end])
        }
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if gcd[0][i] == nums[i] {
            result = append(result, i)
        }
    }

    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}