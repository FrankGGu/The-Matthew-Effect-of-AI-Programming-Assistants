func distributeCandies(n int, limit int) int64 {
    var count int64 = 0
    for a := 0; a <= limit; a++ {
        for b := 0; b <= limit; b++ {
            c := n - a - b
            if c >= 0 && c <= limit {
                count++
            }
        }
    }
    return count
}