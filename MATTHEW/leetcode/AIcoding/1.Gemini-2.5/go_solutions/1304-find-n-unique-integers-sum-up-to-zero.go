func sumZero(n int) []int {
    result := make([]int, n)
    k := 0

    for i := 1; i <= n / 2; i++ {
        result[k] = i
        k++
        result[k] = -i
        k++
    }

    if n % 2 == 1 {
        result[k] = 0
    }

    return result
}