var maximumEnergyBoost = function(drinks) {
    let max1 = -Infinity;
    let max2 = -Infinity;

    for (let i = 0; i < drinks.length; i++) {
        const currentDrinkEnergy = drinks[i];

        if (currentDrinkEnergy > max1) {
            max2 = max1;
            max1 = currentDrinkEnergy;
        } else if (currentDrinkEnergy > max2) {
            max2 = currentDrinkEnergy;
        }
    }

    return max1 + max2;
};