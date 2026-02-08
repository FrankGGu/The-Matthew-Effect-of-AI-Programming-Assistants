func maxEnergyBoost(drinks [][]int) int {
    maxBoost := 0
    n := len(drinks)

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            boost := drinks[i][0] + drinks[j][0] - drinks[i][1] - drinks[j][1]
            if boost > maxBoost {
                maxBoost = boost
            }
        }
    }

    return maxBoost
}