var numFactoredBinaryTrees = function(arr) {
    const MOD = 1e9 + 7;
    arr.sort((a, b) => a - b);
    const dp = new Map();
    let result = 0;

    for (const a of arr) {
        dp.set(a, 1);
        for (let i = 0; i < arr.length; i++) {
            if (arr[i] >= a) break;
            if (a % arr[i] === 0) {
                const right = a / arr[i];
                if (dp.has(right)) {
                    dp.set(a, (dp.get(a) + dp.get(arr[i]) * dp.get(right)) % MOD);
                }
            }
        }
        result = (result + dp.get(a)) % MOD;
    }

    return result;
};