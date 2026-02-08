func countHouses(distance int, houses [][]int) int {
    housesCount := 0
    for _, house := range houses {
        if abs(house[0]) + abs(house[1]) == distance {
            housesCount++
        }
    }
    return housesCount
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}