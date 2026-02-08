function maxEnergyBoost(drinks) {
    drinks.sort((a, b) => b - a);
    return drinks[0] + drinks[1];
}