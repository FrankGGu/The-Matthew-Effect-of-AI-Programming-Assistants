func breakfastCombinations(baseCost int, drinks []int, food []int) int {
    count := 0
    for _, d := range drinks {
        for _, f := range food {
            if d + f + baseCost <= 100 {
                count++
            }
        }
    }
    return count
}