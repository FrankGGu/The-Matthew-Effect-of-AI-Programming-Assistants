var minNumberOfHours = function(initialEnergy, initialExperience, energy, experience) {
    let hours = 0;
    let energyNeeded = 0;
    for (let i = 0; i < energy.length; i++) {
        energyNeeded += energy[i];
    }

    if (initialEnergy <= energyNeeded) {
        hours += (energyNeeded - initialEnergy + 1);
    }

    let currentExperience = initialExperience;
    for (let i = 0; i < experience.length; i++) {
        if (currentExperience <= experience[i]) {
            hours += (experience[i] - currentExperience + 1);
            currentExperience = experience[i] + 1;
        }
        currentExperience += experience[i];
    }

    return hours;
};