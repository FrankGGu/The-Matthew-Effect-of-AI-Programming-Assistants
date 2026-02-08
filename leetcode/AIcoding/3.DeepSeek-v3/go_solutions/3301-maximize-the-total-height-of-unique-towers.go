func maximumUniqueTower(towers [][]int) int {
    seen := make(map[int]bool)
    maxHeight := 0
    currentHeight := 0

    for i := 0; i < len(towers); i++ {
        if !seen[towers[i][0]] {
            seen[towers[i][0]] = true
            currentHeight += towers[i][1]
            if currentHeight > maxHeight {
                maxHeight = currentHeight
            }
        } else {
            for j := 0; j < i; j++ {
                if towers[j][0] == towers[i][0] {
                    seen = make(map[int]bool)
                    currentHeight = 0
                    for k := j + 1; k <= i; k++ {
                        if !seen[towers[k][0]] {
                            seen[towers[k][0]] = true
                            currentHeight += towers[k][1]
                        }
                    }
                    if currentHeight > maxHeight {
                        maxHeight = currentHeight
                    }
                    break
                }
            }
        }
    }

    return maxHeight
}