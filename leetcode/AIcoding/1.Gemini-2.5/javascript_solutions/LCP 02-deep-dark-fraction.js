var deepDarkFraction = function(arr, n) {
    // Initialize the fraction with the last term arr[n]
    let numerator = arr[n];
    let denominator = 1;

    // Iterate backwards from the second to last term (arr[n-1]) down to arr[0]
    for (let i = n - 1; i >= 0; i--) {
        // The current continued fraction term is arr[i] + 1 / (numerator / denominator)
        // This simplifies to arr[i] + denominator / numerator
        // To combine these, we find a common denominator:
        // (arr[i] * numerator + denominator) / numerator

        let nextNumerator = arr[i] * numerator + denominator;
        let nextDenominator = numerator;

        numerator = nextNumerator;
        denominator = nextDenominator;
    }

    // The resulting fraction [numerator, denominator] is often in simplest form
    // due to the properties of continued fractions, so explicit GCD calculation is typically not needed.
    return [numerator, denominator];
};