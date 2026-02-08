package main

func minTrainingHours(energyPercentages []int, trainingHours []int) int {
    n := len(energyPercentages)
    for i := 0; i < n; i++ {
        if energyPercentages[i] > 100 {
            return -1
        }
    }
    total := 0
    for i := 0; i < n; i++ {
        if energyPercentages[i] < 100 {
            total += (100 - energyPercentages[i]) * trainingHours[i]
        }
    }
    return total
}