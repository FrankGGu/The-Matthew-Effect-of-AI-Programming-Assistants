func decrypt(code []int, k int) []int {
    n := len(code)
    result := make([]int, n)

    if k == 0 {
        return result
    }

    var sum int
    if k > 0 {
        for i := 1; i <= k; i++ {
            sum += code[i % n]
        }
        for i := 0; i < n; i++ {
            result[i] = sum
            sum -= code[(i+1) % n]
            sum += code[(i+k+1) % n]
        }
    } else {
        k = -k
        for i := 1; i <= k; i++ {
            sum += code[(n-i) % n]
        }
        for i := 0; i < n; i++ {
            result[i] = sum
            sum -= code[n-((i+k+1)%n)] 
            sum += code[n-(i+1)%n]
        }
    }

    return result
}