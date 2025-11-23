var maximumEnergy = function(energy, k) {
    let maxEnergy = -Infinity;
    const n = energy.length;

    for (let i = 0; i < n; i++) {
        let currentEnergy = 0;
        for (let j = i; j < n; j += k) {
            currentEnergy += energy[j];
        }
        if (currentEnergy > maxEnergy) {
            maxEnergy = currentEnergy;
        }
    }

    return maxEnergy;
};