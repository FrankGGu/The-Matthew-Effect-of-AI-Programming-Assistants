import "sort"

func minNumberOfHours(initialEnergy int, initialExperience int, energy []int, experience []int) int {
	n := len(energy)
	neededEnergy := 0
	for i := 0; i < n; i++ {
		neededEnergy += energy[i]
	}

	neededTrainingHours := 0
	if initialEnergy <= neededEnergy {
		neededTrainingHours = neededEnergy - initialEnergy + 1
	}

	neededExperience := 0
	currentExperience := initialExperience
	for i := 0; i < n; i++ {
		if currentExperience <= experience[i] {
			neededExperience += (experience[i] - currentExperience + 1)
			currentExperience = experience[i] + 1
		}
		currentExperience += experience[i]
	}

	return neededTrainingHours + neededExperience
}