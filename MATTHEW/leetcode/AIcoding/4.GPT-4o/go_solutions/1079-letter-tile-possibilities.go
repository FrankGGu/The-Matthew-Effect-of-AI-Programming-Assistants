func numTilePossibilities(tiles string) int {
    count := make(map[rune]int)
    for _, tile := range tiles {
        count[tile]++
    }
    return backtrack(count)
}

func backtrack(count map[rune]int) int {
    total := 0
    for tile, c := range count {
        if c > 0 {
            total++
            count[tile]--
            total += backtrack(count)
            count[tile]++
        }
    }
    return total
}