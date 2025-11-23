func giveGem(gems []int, operations [][]int) []int {
    for _, op := range operations {
        from := op[0]
        to := op[1]

        transferAmount := gems[from] / 2

        gems[from] -= transferAmount
        gems[to] += transferAmount
    }
    return gems
}