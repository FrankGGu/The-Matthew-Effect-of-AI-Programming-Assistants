var maximumPoints = function(enemyEnergies, currentEnergy) {
    if (enemyEnergies.length === 0) {
        return 0;
    }

    enemyEnergies.sort((a, b) => a - b);

    let points = 0;
    let left = 0;
    let right = enemyEnergies.length - 1;

    while (left <= right) {
        if (currentEnergy >= enemyEnergies[left]) {
            currentEnergy -= enemyEnergies[left];
            points += 1;
            left += 1;
        } else if (points > 0 && left < right) {
            currentEnergy += enemyEnergies[right];
            points -= 1;
            right -= 1;
        } else {
            break;
        }
    }

    return points;
};