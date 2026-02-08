var countGoodMeals = function(deliciousness) {
    const MOD = 10**9 + 7;
    let count = 0;
    const map = new Map();

    for (const d of deliciousness) {
        for (let i = 0; i <= 21; i++) {
            const powerOfTwo = 2**i;
            const complement = powerOfTwo - d;
            if (map.has(complement)) {
                count = (count + map.get(complement)) % MOD;
            }
        }
        map.set(d, (map.get(d) || 0) + 1);
    }

    return count;
};