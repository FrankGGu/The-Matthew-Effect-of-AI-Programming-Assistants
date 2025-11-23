var distributeCandies = function(candyType) {
    const uniqueCandies = new Set(candyType);
    return Math.min(uniqueCandies.size, candyType.length / 2);
};