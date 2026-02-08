func numTilePossibilities(tiles string) int {
    count := make(map[rune]int)
    for _, tile := range tiles {
        count[tile]++
    }

    var backtrack func() int
    backtrack = func() int {
        result := 0
        for char, num := range count {
            if num > 0 {
                result++
                count[char]--
                result += backtrack()
                count[char]++
            }
        }
        return result
    }

    return backtrack()
}