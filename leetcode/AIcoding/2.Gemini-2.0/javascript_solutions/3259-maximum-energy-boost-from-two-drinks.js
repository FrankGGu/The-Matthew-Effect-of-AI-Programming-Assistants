var maxEnergyDrinks = function(drinks) {
    drinks.sort((a, b) => a - b);
    let n = drinks.length;
    if (n === 0) return 0;
    if (n === 1) return 0;

    return drinks[n - 1] - 1 + drinks[n - 2];
};