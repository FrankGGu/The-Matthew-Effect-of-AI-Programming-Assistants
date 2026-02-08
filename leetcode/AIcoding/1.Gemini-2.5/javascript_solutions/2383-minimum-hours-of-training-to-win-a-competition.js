var minNumberOfHours = function(initialEnergy, initialExperience, energy, experience) {
    let trainingHours = 0;
    let currentEnergy = initialEnergy;
    let currentExperience = initialExperience;

    for (let i = 0; i < energy.length; i++) {
        // Check and train for energy
        if (currentEnergy <= energy[i]) {
            let neededEnergyTraining = energy[i] - currentEnergy + 1;
            trainingHours += neededEnergyTraining;
            currentEnergy += neededEnergyTraining;
        }

        // Check and train for experience
        if (currentExperience <= experience[i]) {
            let neededExperienceTraining = experience[i] - currentExperience + 1;
            trainingHours += neededExperienceTraining;
            currentExperience += neededExperienceTraining;
        }

        // After training (if any) and winning the fight
        currentEnergy -= energy[i];
        currentExperience += experience[i];
    }

    return trainingHours;
};