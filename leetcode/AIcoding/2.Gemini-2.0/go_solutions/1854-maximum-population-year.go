func maximumPopulation(logs [][]int) int {
    years := make([]int, 101)
    for _, log := range logs {
        birth := log[0] - 1950
        death := log[1] - 1950
        for i := birth; i < death; i++ {
            years[i]++
        }
    }
    maxPopulation := 0
    maxYear := 1950
    for i, population := range years {
        if population > maxPopulation {
            maxPopulation = population
            maxYear = 1950 + i
        }
    }
    return maxYear
}