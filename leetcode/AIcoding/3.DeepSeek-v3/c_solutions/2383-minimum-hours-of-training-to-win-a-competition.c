int minNumberOfHours(int initialEnergy, int initialExperience, int* energy, int energySize, int* experience, int experienceSize) {
    int totalEnergy = 0;
    for (int i = 0; i < energySize; i++) {
        totalEnergy += energy[i];
    }
    int energyTraining = totalEnergy - initialEnergy + 1;
    if (energyTraining < 0) energyTraining = 0;

    int expTraining = 0;
    int currentExp = initialExperience;
    for (int i = 0; i < experienceSize; i++) {
        if (currentExp <= experience[i]) {
            int needed = experience[i] - currentExp + 1;
            expTraining += needed;
            currentExp += needed;
        }
        currentExp += experience[i];
    }

    return energyTraining + expTraining;
}