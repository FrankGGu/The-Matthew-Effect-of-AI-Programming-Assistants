var nonSpecialCount = function(l, r) {
    const maxSqrtR = Math.floor(Math.sqrt(r));
    const isPrime = new Array(maxSqrtR + 1).fill(true);

    if (maxSqrtR >= 0) isPrime[0] = false;
    if (maxSqrtR >= 1) isPrime[1] = false;

    for (let p = 2; p * p <= maxSqrtR; p++) {
        if (isPrime[p]) {
            for (let multiple = p * p; multiple <= maxSqrtR; multiple += p) {
                isPrime[multiple] = false;
            }
        }
    }

    let specialCount = 0;
    for (let p = 2; p <= maxSqrtR; p++) {
        if (isPrime[p]) {
            const square = p * p;
            if (square >= l && square <= r) {
                specialCount++;
            }
        }
    }

    return (r - l + 1) - specialCount;
};