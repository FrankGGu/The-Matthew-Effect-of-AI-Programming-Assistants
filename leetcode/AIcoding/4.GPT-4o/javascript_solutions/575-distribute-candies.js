var distributeCandies = function(candies) {
    const uniqueCandies = new Set(candies);
    return Math.min(uniqueCandies.size, candies.length / 2);
};