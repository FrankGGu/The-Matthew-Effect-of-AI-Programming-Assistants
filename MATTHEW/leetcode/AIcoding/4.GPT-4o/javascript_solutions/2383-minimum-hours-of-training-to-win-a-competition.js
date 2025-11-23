var minNumberOfHours = function(initialEnergy, initialExperience, energy, experience) {
    let totalHours = 0;

    for (let i = 0; i < energy.length; i++) {
        if (initialEnergy <= energy[i]) {
            totalHours += energy[i] - initialEnergy + 1;
            initialEnergy = energy[i] + 1;
        } else {
            initialEnergy -= energy[i];
        }

        if (initialExperience <= experience[i]) {
            totalHours += experience[i] - initialExperience + 1;
            initialExperience = experience[i] + 1;
        } else {
            initialExperience += experience[i];
        }
    }

    return totalHours;
};