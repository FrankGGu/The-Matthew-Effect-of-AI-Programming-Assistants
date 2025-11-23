func candy(ratings []int) int {
    n := len(ratings)
    if n == 0 {
        return 0
    }

    candies := make([]int, n)
    for i := range candies {
        candies[i] = 1 // Each child gets at least one candy