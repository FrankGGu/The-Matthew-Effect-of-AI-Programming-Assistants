var kidsWithCandies = function(candies, extraCandies) {
    let maxCandies = 0;
    for (let i = 0; i < candies.length; i++) {
        if (candies[i] > maxCandies) {
            maxCandies = candies[i];
        }
    }

    const result = [];
    for (let i = 0; i < candies.length; i++) {
        result.push(candies[i] + extraCandies >= maxCandies);
    }

    return result;
};