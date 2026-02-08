var minNumberOfHours = function(initialEnergy, initialExperience, energy, experience) {
    let requiredEnergy = 0;
    let requiredExperience = 0;
    let currentEnergy = initialEnergy;
    let currentExperience = initialExperience;

    for (let i = 0; i < energy.length; i++) {
        if (currentEnergy <= energy[i]) {
            let needed = energy[i] - currentEnergy + 1;
            requiredEnergy += needed;
            currentEnergy += needed;
        }
        currentEnergy -= energy[i];

        if (currentExperience <= experience[i]) {
            let needed = experience[i] - currentExperience + 1;
            requiredExperience += needed;
            currentExperience += needed;
        }
        currentExperience += experience[i];
    }

    return requiredEnergy + requiredExperience;
};