var countPairs = function(deliciousness) {
    const MOD = 1e9 + 7;
    let maxSum = 0;
    for (const num of deliciousness) {
        maxSum = Math.max(maxSum, num * 2);
    }
    const map = new Map();
    let res = 0;
    for (const num of deliciousness) {
        let power = 1;
        while (power <= maxSum) {
            res = (res + (map.get(power - num) || 0)) % MOD;
            power *= 2;
        }
        map.set(num, (map.get(num) || 0) + 1);
    }
    return res;
};