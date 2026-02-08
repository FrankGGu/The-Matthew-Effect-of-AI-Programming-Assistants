#include <stdio.h>
#include <stdlib.h>

int minTrainingHours(int* energy, int energySize, int initialEnergy, int initialExperience, int* experience, int experienceSize) {
    int totalHours = 0;
    int currentEnergy = initialEnergy;
    int currentExperience = initialExperience;

    for (int i = 0; i < energySize; i++) {
        if (currentEnergy <= energy[i]) {
            totalHours += energy[i] - currentEnergy + 1;
            currentEnergy = energy[i] + 1;
        }
        currentEnergy -= energy[i];

        if (currentExperience <= experience[i]) {
            totalHours += experience[i] - currentExperience + 1;
            currentExperience = experience[i] + 1;
        }
        currentExperience += experience[i];
    }

    return totalHours;
}