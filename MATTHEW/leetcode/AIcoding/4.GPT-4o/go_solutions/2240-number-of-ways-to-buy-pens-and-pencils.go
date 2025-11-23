func waysToBuyPensPencils(totalMoney int, costPen int, costPencil int) int64 {
    count := int64(0)
    for i := 0; i <= totalMoney/costPen; i++ {
        remainingMoney := totalMoney - i*costPen
        count += int64(remainingMoney/costPencil + 1)
    }
    return count
}