var maxDistinctPrimeFactors = function(nums) {
    let count = 0;
    let seen = new Set();

    for (let num of nums) {
        let factors = new Set();
        for (let i = 2; i * i <= num; i++) {
            while (num % i === 0) {
                factors.add(i);
                num /= i;
            }
        }
        if (num > 1) {
            factors.add(num);
        }

        let added = false;
        for (let factor of factors) {
            if (!seen.has(factor)) {
                seen.add(factor);
                added = true;
            }
        }

        if (!added && factors.size > 0) {
            count++;
        }
    }

    return count;
};