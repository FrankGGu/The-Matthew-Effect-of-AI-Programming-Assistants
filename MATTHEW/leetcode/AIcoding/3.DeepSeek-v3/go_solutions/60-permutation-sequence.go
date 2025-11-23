func getPermutation(n int, k int) string {
    factorial := make([]int, n+1)
    factorial[0] = 1
    for i := 1; i <= n; i++ {
        factorial[i] = factorial[i-1] * i
    }

    numbers := make([]int, n)
    for i := 0; i < n; i++ {
        numbers[i] = i + 1
    }

    k--
    var result strings.Builder
    for i := 1; i <= n; i++ {
        index := k / factorial[n-i]
        result.WriteString(strconv.Itoa(numbers[index]))
        numbers = append(numbers[:index], numbers[index+1:]...)
        k -= index * factorial[n-i]
    }

    return result.String()
}