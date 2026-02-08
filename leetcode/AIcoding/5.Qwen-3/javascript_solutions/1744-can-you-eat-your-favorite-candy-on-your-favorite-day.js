function canEat(candyType, days) {
    const n = candyType.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + candyType[i];
    }
    const result = [];
    for (const [favoriteDay, favoriteCandy, dailyCandy] of days) {
        const totalCandies = prefix[favoriteDay + 1] - prefix[0];
        const required = favoriteCandy + (favoriteDay * dailyCandy);
        result.push(totalCandies >= required);
    }
    return result;
}