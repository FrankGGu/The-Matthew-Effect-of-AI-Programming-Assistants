func stoneGameIX(stones []int) bool {
    sum := 0
    count := [3]int{0, 0, 0}

    for _, stone := range stones {
        sum += stone
        count[stone%3]++
    }

    if count[0] > 0 {
        if count[1] > 0 && count[2] > 0 {
            return true
        }
        return count[1] > 1 || count[2] > 1
    }
    return count[1] > 0 && count[2] > 0
}