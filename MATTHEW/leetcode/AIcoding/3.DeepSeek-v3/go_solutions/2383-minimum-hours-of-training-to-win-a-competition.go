func minNumberOfHours(initialEnergy int, initialExperience int, energy []int, experience []int) int {
    totalEnergy := 0
    for _, e := range energy {
        totalEnergy += e
    }
    energyNeeded := 0
    if totalEnergy >= initialEnergy {
        energyNeeded = totalEnergy - initialEnergy + 1
    }

    expNeeded := 0
    currentExp := initialExperience
    for _, exp := range experience {
        if currentExp <= exp {
            diff := exp - currentExp + 1
            expNeeded += diff
            currentExp += diff
        }
        currentExp += exp
    }

    return energyNeeded + expNeeded
}