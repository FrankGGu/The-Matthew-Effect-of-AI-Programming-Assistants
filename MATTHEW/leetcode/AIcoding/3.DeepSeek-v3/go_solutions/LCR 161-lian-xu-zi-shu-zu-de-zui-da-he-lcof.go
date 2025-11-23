func maxSales(sales []int) int {
    if len(sales) == 0 {
        return 0
    }
    maxSum, currentSum := sales[0], sales[0]
    for i := 1; i < len(sales); i++ {
        if currentSum < 0 {
            currentSum = 0
        }
        currentSum += sales[i]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}