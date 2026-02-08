var largestPalindrome = function(n, k) {
    if (n === 1) {
        for (let num = 9; num >= 1; num--) {
            if (num % k === 0) {
                return num % 1337;
            }
        }
        return 0;
    }

    const upperBound = Math.pow(10, n) - 1;
    const lowerBound = Math.pow(10, n - 1);

    for (let i = upperBound; i >= lowerBound; i--) {
        const s = String(i);
        const reversedS = s.split('').reverse().join('');
        const p = BigInt(s + reversedS);

        if (p % BigInt(k) === 0n) {
            for (let j = BigInt(upperBound); j * j >= p; j--) {
                if (p % j === 0n) {
                    const otherFactor = p / j;
                    if (otherFactor >= BigInt(lowerBound)) {
                        return Number(p % 1337n);
                    }
                }
            }
        }
    }

    return 0;
};