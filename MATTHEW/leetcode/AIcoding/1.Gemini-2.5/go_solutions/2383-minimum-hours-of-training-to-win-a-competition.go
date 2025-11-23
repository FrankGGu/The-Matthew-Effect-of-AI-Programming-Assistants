func minNumberOfHours(initialEnergy int, initialExperience int, energy []int, experience []int) int {
	requiredAddEnergy := 0
	requiredAddExperience := 0

	currentEnergy := initialEnergy
	currentExperience := initialExperience

	for i := 0; i < len(energy); i++ {
		if currentEnergy <= energy[i] {
			needed := energy[i] - currentEnergy + 1
			requiredAddEnergy += needed
			currentEnergy += needed
		}
		currentEnergy -= energy[i]

		if currentExperience <= experience[i] {
			needed := experience[i] - currentExperience + 1
			requiredAddExperience += needed
			currentExperience += needed
		}
		currentExperience += experience[i]
	}

	return requiredAddEnergy + requiredAddExperience
}