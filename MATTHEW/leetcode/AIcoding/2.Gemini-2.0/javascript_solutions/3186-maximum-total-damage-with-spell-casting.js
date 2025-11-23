var maxTotalDamage = function(damage, armor, k) {
    let totalDamage = 0;
    let maxDamage = 0;
    let maxIndex = -1;

    for (let i = 0; i < damage.length; i++) {
        totalDamage += damage[i];
        if (damage[i] > maxDamage) {
            maxDamage = damage[i];
            maxIndex = i;
        }
    }

    if (maxIndex !== -1) {
        totalDamage -= Math.min(damage[maxIndex], armor);
    }

    return totalDamage;
};