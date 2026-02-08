function countPairs(mealNumbers) {
    const mod = 10 ** 9 + 7;
    const count = {};
    let result = 0;

    for (const num of mealNumbers) {
        for (let i = 0; i <= 20; i++) {
            const target = (1 << i) - num;
            if (count[target]) {
                result = (result + count[target]) % mod;
            }
        }
        count[num] = (count[num] || 0) + 1;
    }

    return result;
}