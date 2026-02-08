var closestPrimes = function(left, right) {
    const maxVal = right;
    const isPrime = new Array(maxVal + 1).fill(true);
    isPrime[0] = false;
    isPrime[1] = false;

    for (let p = 2; p * p <= maxVal; p++) {
        if (isPrime[p]) {
            for (let multiple = p * p; multiple <= maxVal; multiple += p) {
                isPrime[multiple] = false;
            }
        }
    }

    const primesInRange = [];
    for (let i = left; i <= right; i++) {
        if (isPrime[i]) {
            primesInRange.push(i);
        }
    }

    if (primesInRange.length < 2) {
        return [-1, -1];
    }

    let minDiff = Infinity;
    let result = [-1, -1];

    for (let i = 0; i < primesInRange.length - 1; i++) {
        const num1 = primesInRange[i];
        const num2 = primesInRange[i + 1];
        const currentDiff = num2 - num1;

        if (currentDiff < minDiff) {
            minDiff = currentDiff;
            result = [num1, num2];
        }
    }

    return result;
};