func maxAmountAfterTwoDays(amount int) int {
    maxVal := amount
    for i := 0; i <= 2; i++ {
        for j := 0; j <= 2; j++ {
            if i+j <= 2 {
                current := amount
                if i == 1 {
                    current = current * 2
                } else if i == 2 {
                    current = current * 2 * 2
                }
                if j == 1 {
                    current = current / 2
                } else if j == 2 {
                    current = current / 2 / 2
                }
                if current > maxVal {
                    maxVal = current
                }
            }
        }
    }
    return maxVal
}