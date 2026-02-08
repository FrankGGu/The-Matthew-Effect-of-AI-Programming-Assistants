var minimumEnergy = function(tasks) {
    let minEnergy = 0;
    let totalEnergy = 0;

    for (let [energy, minimum] of tasks) {
        totalEnergy += energy;
        minEnergy = Math.max(minEnergy, minimum - totalEnergy);
    }

    return minEnergy + 1;
};