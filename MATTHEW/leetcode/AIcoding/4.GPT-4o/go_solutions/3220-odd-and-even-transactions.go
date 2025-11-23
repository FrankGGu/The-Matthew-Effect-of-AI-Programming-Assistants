func oddEvenTransactions(transactions []int) []int {
    odd := make([]int, 0)
    even := make([]int, 0)

    for _, t := range transactions {
        if t%2 == 0 {
            even = append(even, t)
        } else {
            odd = append(odd, t)
        }
    }

    result := make([]int, 0)
    result = append(result, odd...)
    result = append(result, even...)

    return result
}