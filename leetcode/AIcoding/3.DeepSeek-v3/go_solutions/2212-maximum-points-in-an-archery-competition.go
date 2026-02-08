func maximumBobPoints(numArrows int, aliceArrows []int) []int {
    maxPoints := 0
    bestConfig := make([]int, 12)

    for mask := 0; mask < (1 << 12); mask++ {
        points := 0
        arrows := 0
        temp := make([]int, 12)

        for i := 0; i < 12; i++ {
            if mask & (1 << i) != 0 {
                arrows += aliceArrows[i] + 1
                temp[i] = aliceArrows[i] + 1
                points += i
            }
        }

        if arrows <= numArrows && points > maxPoints {
            maxPoints = points
            bestConfig = temp
        }
    }

    total := 0
    for _, v := range bestConfig {
        total += v
    }

    if total < numArrows {
        bestConfig[0] += numArrows - total
    }

    return bestConfig
}