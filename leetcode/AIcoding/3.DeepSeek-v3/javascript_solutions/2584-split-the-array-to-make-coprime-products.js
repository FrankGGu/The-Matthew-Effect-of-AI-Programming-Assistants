var findValidSplit = function(nums) {
    const n = nums.length;
    const left = {};
    const right = {};

    const factorize = (x) => {
        const factors = {};
        for (let i = 2; i * i <= x; i++) {
            while (x % i === 0) {
                factors[i] = (factors[i] || 0) + 1;
                x = Math.floor(x / i);
            }
        }
        if (x > 1) {
            factors[x] = (factors[x] || 0) + 1;
        }
        return factors;
    };

    for (const num of nums) {
        const factors = factorize(num);
        for (const p in factors) {
            right[p] = (right[p] || 0) + factors[p];
        }
    }

    let common = 0;
    for (let i = 0; i < n - 1; i++) {
        const factors = factorize(nums[i]);
        for (const p in factors) {
            left[p] = (left[p] || 0) + factors[p];
            right[p] -= factors[p];
            if (right[p] === 0) {
                common--;
            }
            if (left[p] === 1 && right[p] >= 1) {
                common++;
            }
        }
        if (common === 0) {
            return i;
        }
    }

    return -1;
};