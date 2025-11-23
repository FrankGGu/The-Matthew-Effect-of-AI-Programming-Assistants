func waysToBuyPensPencils(total int, cost1 int, cost2 int) int64 {
    var ways int64 = 0

    for i := 0; ; i++ {
        costPens := i * cost1
        if costPens > total {
            break
        }

        remainingMoney := total - costPens
        numPencils := remainingMoney / cost2

        ways += int64(numPencils + 1)
    }

    return ways
}