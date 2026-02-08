var findValidSplit = function(nums) {
    const gcd = (a, b) => {
        if (b === 0) return a;
        return gcd(b, a % b);
    };

    const primeFactors = (n) => {
        const factors = new Set();
        while (n % 2 === 0) {
            factors.add(2);
            n /= 2;
        }
        for (let i = 3; i <= Math.sqrt(n); i += 2) {
            while (n % i === 0) {
                factors.add(i);
                n /= i;
            }
        }
        if (n > 2) {
            factors.add(n);
        }
        return factors;
    };

    const n = nums.length;
    const leftFactors = new Array(n);
    const rightFactors = new Array(n);

    for (let i = 0; i < n; i++) {
        leftFactors[i] = primeFactors(nums[i]);
    }

    for (let i = 0; i < n; i++) {
        rightFactors[i] = primeFactors(nums[i]);
    }

    const leftUnion = new Array(n);
    leftUnion[0] = new Set(leftFactors[0]);
    for (let i = 1; i < n; i++) {
        leftUnion[i] = new Set(leftUnion[i - 1]);
        for (const factor of leftFactors[i]) {
            leftUnion[i].add(factor);
        }
    }

    const rightUnion = new Array(n);
    rightUnion[n - 1] = new Set(rightFactors[n - 1]);
    for (let i = n - 2; i >= 0; i--) {
        rightUnion[i] = new Set(rightUnion[i + 1]);
        for (const factor of rightFactors[i]) {
            rightUnion[i].add(factor);
        }
    }

    for (let i = 0; i < n - 1; i++) {
        let coprime = true;
        for (const factor of leftUnion[i]) {
            if (rightUnion[i + 1].has(factor)) {
                coprime = false;
                break;
            }
        }
        if (coprime) {
            return i;
        }
    }

    return -1;
};