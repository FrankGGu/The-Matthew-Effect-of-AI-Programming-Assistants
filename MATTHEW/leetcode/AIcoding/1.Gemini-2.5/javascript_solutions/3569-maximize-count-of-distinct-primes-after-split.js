function getDistinctPrimeFactors(num) {
    const factors = new Set();
    if (num <= 1) {
        return factors;
    }

    if (num % 2 === 0) {
        factors.add(2);
        while (num % 2 === 0) {
            num /= 2;
        }
    }

    for (let i = 3; i * i <= num; i += 2) {
        if (num % i === 0) {
            factors.add(i);
            while (num % i === 0) {
                num /= i;
            }
        }
    }

    if (num > 1) {
        factors.add(num);
    }

    return factors;
}

var maximizeCountOfDistinctPrimesAfterSplit = function(n) {
    let maxCount = 0;

    for (let a = 1; a < n; a++) {
        const b = n - a;

        const factorsA = getDistinctPrimeFactors(a);
        const factorsB = getDistinctPrimeFactors(b);

        const unionSet = new Set(factorsA);
        for (const factor of factorsB) {
            unionSet.add(factor);
        }

        maxCount = Math.max(maxCount, unionSet.size);
    }

    return maxCount;
};