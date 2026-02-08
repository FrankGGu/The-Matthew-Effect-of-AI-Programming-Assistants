func distributeCandies(candies int, limit int) int {
    count := 0
    for c1 := 0; c1 <= limit; c1++ {
        for c2 := 0; c2 <= limit; c2++ {
            c3 := candies - c1 - c2
            if c3 >= 0 && c3 <= limit {
                count++
            }
        }
    }
    return count
}