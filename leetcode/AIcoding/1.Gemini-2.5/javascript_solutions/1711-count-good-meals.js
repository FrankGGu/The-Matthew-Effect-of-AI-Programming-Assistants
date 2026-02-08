var countGoodMeals = function(deliciousness) {
    const MOD = 10**9 + 7;
    let count = 0;
    const freqMap = new Map();

    const powersOfTwo = [];
    for (let i = 0; i <= 21; i++) {
        powersOfTwo.push(1 << i);
    }

    for (const num of deliciousness) {
        for (const power of powersOfTwo) {
            const complement = power - num;
            if (complement >= 0 && freqMap.has(complement)) {
                count = (count + freqMap.get(complement)) % MOD;
            }
        }
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    return count;
};