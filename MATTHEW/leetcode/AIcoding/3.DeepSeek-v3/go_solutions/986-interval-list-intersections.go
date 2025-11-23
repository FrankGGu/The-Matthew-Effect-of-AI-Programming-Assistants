func intervalIntersection(firstList [][]int, secondList [][]int) [][]int {
    var res [][]int
    i, j := 0, 0
    for i < len(firstList) && j < len(secondList) {
        a1, a2 := firstList[i][0], firstList[i][1]
        b1, b2 := secondList[j][0], secondList[j][1]
        if a2 < b1 {
            i++
        } else if b2 < a1 {
            j++
        } else {
            start := max(a1, b1)
            end := min(a2, b2)
            res = append(res, []int{start, end})
            if a2 < b2 {
                i++
            } else {
                j++
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}