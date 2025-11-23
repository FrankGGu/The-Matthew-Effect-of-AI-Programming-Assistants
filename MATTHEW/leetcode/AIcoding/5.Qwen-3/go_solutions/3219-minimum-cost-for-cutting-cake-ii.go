package main

func minCost(n int, m int, horizontalCut []int, verticalCut []int) int {
    sort.Ints(horizontalCut)
    sort.Ints(verticalCut)

    h := len(horizontalCut)
    v := len(verticalCut)

    i, j := h-1, v-1
    cost := 0
    hCount, vCount := 1, 1

    for i >= 0 || j >= 0 {
        if i >= 0 && j >= 0 {
            if horizontalCut[i] > verticalCut[j] {
                cost += horizontalCut[i] * vCount
                hCount++
                i--
            } else {
                cost += verticalCut[j] * hCount
                vCount++
                j--
            }
        } else if i >= 0 {
            cost += horizontalCut[i] * vCount
            hCount++
            i--
        } else {
            cost += verticalCut[j] * hCount
            vCount++
            j--
        }
    }

    return cost
}