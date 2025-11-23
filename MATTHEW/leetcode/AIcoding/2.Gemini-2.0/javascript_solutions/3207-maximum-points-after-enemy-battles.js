var maxPoints = function(energy, armor) {
    let sum = 0;
    let maxArmor = 0;
    for (let i = 0; i < energy.length; i++) {
        sum += energy[i];
        maxArmor = Math.max(maxArmor, armor[i]);
    }

    return sum - Math.min(maxArmor, sum - Math.max(...energy));
};