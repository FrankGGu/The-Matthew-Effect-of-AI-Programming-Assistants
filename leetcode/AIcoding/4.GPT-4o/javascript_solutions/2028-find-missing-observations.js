function findMissingObservations(observed, n) {
    const totalSum = (n * (n + 1)) / 2;
    const observedSum = observed.reduce((a, b) => a + b, 0);
    const missingSum = totalSum - observedSum;

    const totalSquareSum = (n * (n + 1) * (2 * n + 1)) / 6;
    const observedSquareSum = observed.reduce((a, b) => a + b * b, 0);
    const missingSquareSum = totalSquareSum - observedSquareSum;

    const missingXPlusY = missingSum;
    const missingXSquarePlusYSquare = missingSquareSum;

    const missingXMinusY = Math.sqrt(missingXSquarePlusYSquare - missingXPlusY * missingXPlusY);

    const missingX = (missingXPlusY + missingXMinusY) / 2;
    const missingY = (missingXPlusY - missingXMinusY) / 2;

    return [missingX, missingY];
}