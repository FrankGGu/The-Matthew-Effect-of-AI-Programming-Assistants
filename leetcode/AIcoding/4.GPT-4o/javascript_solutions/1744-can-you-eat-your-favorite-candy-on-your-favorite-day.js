var canEat = function(candiesCount, queries) {
    const prefixSum = new Array(candiesCount.length);
    prefixSum[0] = candiesCount[0];
    for (let i = 1; i < candiesCount.length; i++) {
        prefixSum[i] = prefixSum[i - 1] + candiesCount[i];
    }

    const result = [];
    for (const [favoriteType, favoriteDay, dailyCap] of queries) {
        const totalCandiesBefore = favoriteType === 0 ? 0 : prefixSum[favoriteType - 1];
        const totalCandiesOnFavoriteType = prefixSum[favoriteType];
        const canEat = (favoriteDay + 1) <= (totalCandiesOnFavoriteType / dailyCap) && 
                       (favoriteDay >= totalCandiesBefore / dailyCap);
        result.push(canEat);
    }

    return result;
};