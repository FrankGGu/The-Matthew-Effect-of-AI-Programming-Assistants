func beautifulArray(n int) []int {
    if n == 1 {
        return []int{1}
    }

    left := beautifulArray((n + 1) / 2) // ceil(n/2)
    right := beautifulArray(n / 2)      // floor(n/2)

    result