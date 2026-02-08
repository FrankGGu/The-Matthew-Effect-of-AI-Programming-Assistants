var maximumEnergy = function(energy, k) {
    const n = energy.length;
    let maxEnergy = -Infinity;

    for (let i = 0; i < n; i++) {
        let currentEnergy = 0;
        for (let j = i; j < n; j += k) {
            currentEnergy += energy[j];
        }
        maxEnergy = Math.max(maxEnergy, currentEnergy);
    }

    return maxEnergy;
};