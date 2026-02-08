func maximumPopulation(logs [][]int) int {
    yearCount := [2050]int{}

    for _, log := range logs {
        for year := log[0]; year < log[1]; year++ {
            yearCount[year]++
        }
    }

    maxPopulation := 0
    maxYear := 0
    for year := 1950; year < 2050; year++ {
        if yearCount[year] > maxPopulation {
            maxPopulation = yearCount[year]
            maxYear = year
        }
    }

    return maxYear
}