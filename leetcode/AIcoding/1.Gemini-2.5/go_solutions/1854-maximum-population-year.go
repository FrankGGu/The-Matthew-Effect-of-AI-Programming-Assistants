func maximumPopulation(logs [][]int) int {
    minYear := 1950
    maxYear := 2050 // The maximum possible death_year. People are alive up to maxYear-1.

    // populationChanges array size: maxYear - minYear + 1
    // Index i corresponds to year minYear + i.
    // E.g., for year 1950, index is 0. For year 2050, index is 100.
    populationChanges := make([]int, maxYear - minYear + 1)

    for _, log := range logs {
        birth := log[0]
        death := log[1]

        // Increment population at birth year
        populationChanges[birth - minYear]++

        // Decrement population at death year
        // A person is alive up to death-1. At death year, they are no longer counted.
        // So, the population decreases starting from 'death' year.
        // The problem constraints guarantee death <= 2050, so death - minYear will be a valid index.
        populationChanges[death - minYear]--
    }

    currentPopulation := 0
    maxPopulation := 0
    maxPopulationYear := minYear // Initialize with the earliest possible year (1950)

    // Iterate through the populationChanges array to calculate actual population for each year.
    // We are interested in years from minYear (1950) up to maxYear-1 (2049),
    // as no one is alive in or after maxYear (2050) based on problem definition (death_year <= 2050).
    // The loop runs for index i from 0 to (maxYear - 1) - minYear.
    // For minYear=1950, maxYear=2050, this means i goes from 0 to 99,
    // corresponding to years 1950 to 2049.
    for i := 0; i < maxYear - minYear; i++ { 
        year := minYear + i
        currentPopulation += populationChanges[i]

        if currentPopulation > maxPopulation {
            maxPopulation = currentPopulation
            maxPopulationYear = year
        }
    }

    return maxPopulationYear
}