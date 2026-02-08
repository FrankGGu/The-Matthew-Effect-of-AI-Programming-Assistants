func maximumPopulation(logs [][]int) int {
    years := make([]int, 101) // 1950 to 2050
    for _, log := range logs {
        birth, death := log[0], log[1]
        years[birth-1950]++
        years[death-1950]--
    }

    maxPop := 0
    currentPop := 0
    result := 0
    for i := 0; i < len(years); i++ {
        currentPop += years[i]
        if currentPop > maxPop {
            maxPop = currentPop
            result = i + 1950
        }
    }
    return result
}