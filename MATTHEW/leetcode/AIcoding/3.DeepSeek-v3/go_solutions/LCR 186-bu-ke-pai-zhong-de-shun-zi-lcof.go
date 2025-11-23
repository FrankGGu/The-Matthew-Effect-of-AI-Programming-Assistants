func checkDynasty(dice []int) bool {
    zeroCount := 0
    for _, num := range dice {
        if num == 0 {
            zeroCount++
        }
    }

    min, max := 7, 0
    for _, num := range dice {
        if num != 0 {
            if num < min {
                min = num
            }
            if num > max {
                max = num
            }
        }
    }

    return max - min + 1 <= len(dice) + zeroCount
}