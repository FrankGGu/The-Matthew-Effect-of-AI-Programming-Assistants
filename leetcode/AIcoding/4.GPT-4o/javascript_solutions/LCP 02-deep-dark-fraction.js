function deepDarkFraction(n) {
    let numerator = 1;
    let denominator = 1;

    for (let i = 1; i < n; i++) {
        denominator += numerator;
        numerator = denominator - numerator;
    }

    return `${numerator}/${denominator}`;
}