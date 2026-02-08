func giveGem(gem []int, operations [][]int) int {
    for _, op := range operations {
        x, y := op[0], op[1]
        give := gem[x] / 2
        gem[x] -= give
        gem[y] += give
    }
    max, min := gem[0], gem[0]
    for _, g := range gem {
        if g > max {
            max = g
        }
        if g < min {
            min = g
        }
    }
    return max - min
}