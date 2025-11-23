int minNumberOfHours(int initialEnergy, int initialExperience, int[] energy, int[] experience, int energySize) {
    int totalEnergyNeeded = 0;
    int totalExperienceNeeded = 0;

    for (int i = 0; i < energySize; i++) {
        totalEnergyNeeded += energy[i];
        if (initialExperience <= experience[i]) {
            totalExperienceNeeded += experience[i] - initialExperience + 1;
            initialExperience += experience[i] - initialExperience + 1;
        }
        initialExperience += experience[i];
    }

    return totalEnergyNeeded >= initialEnergy ? totalEnergyNeeded - initialEnergy + 1 : 0 + totalExperienceNeeded;
}