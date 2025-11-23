func maximumScore(a int, b int, c int) int {
    stones := []int{a, b, c}
    sort.Ints(stones)
    score := 0

    for stones[2] > 0 && stones[1] > 0 {
        score++
        stones[2]--
        stones[1]--
        sort.Ints(stones)
    }

    return score
}