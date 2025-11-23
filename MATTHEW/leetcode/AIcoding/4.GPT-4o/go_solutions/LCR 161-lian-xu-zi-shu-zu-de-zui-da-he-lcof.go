func maxSalesDays(sales []int) int {
    maxSales := 0
    currentSales := 0
    for _, sale := range sales {
        if sale > maxSales {
            maxSales = sale
            currentSales = 1
        } else if sale == maxSales {
            currentSales++
        }
    }
    return currentSales
}