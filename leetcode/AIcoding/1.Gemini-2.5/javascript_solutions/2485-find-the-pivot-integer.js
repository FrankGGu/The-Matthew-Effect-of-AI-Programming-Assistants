var pivotInteger = function(n) {
    const sumTotal = n * (n + 1) / 2;

    // We are looking for an x such that sum(1 to x) = sum(x to n)
    // sum(1 to x) = x * (x + 1) / 2
    // sum(x to n) = sum(1 to n) - sum(1 to x-1)
    //             = n * (n + 1) / 2 - (x - 1) * x / 2
    //
    // So, x * (x + 1) / 2 = n * (n + 1) / 2 - (x - 1) * x / 2
    // Multiply by 2:
    // x * (x + 1) = n * (n + 1) - (x - 1) * x
    // x^2 + x = n^2 + n - (x^2 - x)
    // x^2 + x = n^2 + n - x^2 + x
    // 2 * x^2 = n^2 + n
    // x^2 = (n^2 + n) / 2
    // x = sqrt((n^2 + n) / 2)

    const potentialXSquared = sumTotal; // This is (n^2 + n) / 2
    const x = Math.sqrt(potentialXSquared);

    if (Number.isInteger(x)) {
        return x;
    } else {
        return -1;
    }
};