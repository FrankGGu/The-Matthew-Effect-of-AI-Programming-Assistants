int minNumberOfHours(int initialEnergy, int initialExperience, int* energy, int energySize, int* experience, int experienceSize) {
    int hours = 0;
    for (int i = 0; i < energySize; i++) {
        if (initialEnergy <= energy[i]) {
            hours += (energy[i] - initialEnergy + 1);
            initialEnergy = energy[i] + 1;
        }
        initialEnergy -= energy[i];

        if (initialExperience <= experience[i]) {
            hours += (experience[i] - initialExperience + 1);
            initialExperience = experience[i] + 1;
        }
        initialExperience += experience[i];
    }
    return hours;
}