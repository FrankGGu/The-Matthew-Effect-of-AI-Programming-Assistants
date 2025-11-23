func waysToBuyPensPencils(total int, cost1 int, cost2 int) int64 {
    var ways int64 = 0
    maxPens := total / cost1
    for pens := 0; pens <= maxPens; pens++ {
        remaining := total - pens * cost1
        pencils := remaining / cost2
        ways += int64(pencils + 1)
    }
    return ways
}