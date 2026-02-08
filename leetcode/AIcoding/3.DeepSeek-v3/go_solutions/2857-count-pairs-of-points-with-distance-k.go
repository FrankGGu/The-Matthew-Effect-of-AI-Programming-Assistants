func countPairs(points [][]int, k int) int {
    count := 0
    freq := make(map[int]int)

    for _, point := range points {
        x, y := point[0], point[1]
        for a := 0; a <= k; a++ {
            b := k - a
            x1 := a ^ x
            y1 := b ^ y
            count += freq[x1*1000000 + y1]
        }
        freq[x*1000000 + y]++
    }

    return count
}