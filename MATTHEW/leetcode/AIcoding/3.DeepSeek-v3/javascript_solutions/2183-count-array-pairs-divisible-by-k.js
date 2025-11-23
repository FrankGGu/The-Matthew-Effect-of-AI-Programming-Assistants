var countPairs = function(nums, k) {
    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    let count = 0;
    const freq = new Map();

    for (const num of nums) {
        const currGcd = gcd(num, k);
        for (const [key, value] of freq) {
            if ((currGcd * key) % k === 0) {
                count += value;
            }
        }
        freq.set(currGcd, (freq.get(currGcd) || 0) + 1);
    }

    return count;
};