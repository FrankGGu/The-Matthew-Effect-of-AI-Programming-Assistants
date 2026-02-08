var fraction = function(cont) {
    let numerator = 1;
    let denominator = cont[cont.length - 1];

    for (let i = cont.length - 2; i >= 0; i--) {
        numerator = cont[i] * denominator + numerator;
        [numerator, denominator] = [denominator, numerator];
    }

    [numerator, denominator] = [denominator, numerator];

    return [numerator, denominator];
};