var canEat = function(candiesCount, queries) {
    const n = candiesCount.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; ++i) {
        prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
    }
    const res = [];
    for (const [type, day, cap] of queries) {
        const minDay = Math.floor(prefixSum[type] / cap);
        const maxDay = prefixSum[type + 1] - 1;
        res.push(day >= minDay && day <= maxDay);
    }
    return res;
};