func decrypt(code []int, k int) []int {
    n := len(code)
    result := make([]int, n)

    if k == 0 {
        return result
    }

    if k > 0 {
        sum := 0
        for i := 1; i <= k; i++ {
            sum += code[i % n]
        }
        result[0] = sum
        for i := 1; i < n; i++ {
            sum = sum - code[i] + code[(i+k) % n]
            result[i] = sum
        }
    } else {
        sum := 0
        for i := n + k; i < n; i++ {
            sum += code[i % n]
        }
        result[n-1] = sum
        for i := n - 2; i >= 0; i-- {
            sum = sum - code[(i+1)%n] + code[(i+k+n)%n]
            result[i] = sum
        }
    }

    return result
}