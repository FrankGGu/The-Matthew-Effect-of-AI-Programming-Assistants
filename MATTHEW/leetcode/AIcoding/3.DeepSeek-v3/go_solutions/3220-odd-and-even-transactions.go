func oddEvenTransactions(transactions [][]int) []int {
    type key struct {
        day int
        amount int
    }
    count := make(map[key]int)

    for _, t := range transactions {
        k := key{t[0], t[1]}
        count[k]++
    }

    result := make([]int, 0, len(transactions))
    for _, t := range transactions {
        k := key{t[0], t[1]}
        if count[k] % 2 == 1 {
            result = append(result, t[2])
        }
    }

    return result
}