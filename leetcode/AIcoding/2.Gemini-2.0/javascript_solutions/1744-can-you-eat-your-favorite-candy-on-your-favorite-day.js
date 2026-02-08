var canEat = function(candiesCount, queries) {
    const n = candiesCount.length;
    const prefixSum = new Array(n).fill(0);
    prefixSum[0] = candiesCount[0];
    for (let i = 1; i < n; i++) {
        prefixSum[i] = prefixSum[i - 1] + candiesCount[i];
    }

    const result = [];
    for (const query of queries) {
        const favoriteType = query[0];
        const favoriteDay = query[1];
        const dailyCap = query[2];

        const minEaten = favoriteDay + 1;
        const maxEaten = (favoriteDay + 1) * dailyCap;

        const minPossible = favoriteType === 0 ? 1 : prefixSum[favoriteType - 1] + 1;
        const maxPossible = prefixSum[favoriteType];

        result.push(minPossible <= maxEaten && minEaten <= maxPossible);
    }

    return result;
};