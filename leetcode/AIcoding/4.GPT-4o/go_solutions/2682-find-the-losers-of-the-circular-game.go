func findTheLosers(n int, k int) []int {
    if n == 0 {
        return []int{}
    }
    losers := make([]bool, n)
    index := 0

    for count := n; count > 1; {
        index = (index + k - 1) % count
        losers[index] = true
        count--
        for i := index; i < count; i++ {
            losers[i] = losers[i+1]
        }
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if !losers[i] {
            result = append(result, i+1)
        }
    }
    return result
}