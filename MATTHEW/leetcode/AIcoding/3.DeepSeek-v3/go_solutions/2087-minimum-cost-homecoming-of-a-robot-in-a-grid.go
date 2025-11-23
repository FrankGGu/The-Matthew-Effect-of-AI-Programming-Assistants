func minCost(startPos []int, homePos []int, rowCosts []int, colCosts []int) int {
    cost := 0
    x1, y1 := startPos[0], startPos[1]
    x2, y2 := homePos[0], homePos[1]

    if x1 < x2 {
        for i := x1 + 1; i <= x2; i++ {
            cost += rowCosts[i]
        }
    } else if x1 > x2 {
        for i := x1 - 1; i >= x2; i-- {
            cost += rowCosts[i]
        }
    }

    if y1 < y2 {
        for j := y1 + 1; j <= y2; j++ {
            cost += colCosts[j]
        }
    } else if y1 > y2 {
        for j := y1 - 1; j >= y2; j-- {
            cost += colCosts[j]
        }
    }

    return cost
}