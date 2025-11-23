func stoneGameIX(stones []int) bool {
    count := make([]int, 3)
    for _, stone := range stones {
        count[stone % 3]++
    }

    if count[0] % 2 == 0 {
        return count[1] > 0 && count[2] > 0
    }
    return abs(count[1] - count[2]) > 2
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}