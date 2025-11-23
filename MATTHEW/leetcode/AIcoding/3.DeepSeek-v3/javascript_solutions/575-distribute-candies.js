var distributeCandies = function(candyType) {
    const uniqueTypes = new Set(candyType).size;
    const maxEat = candyType.length / 2;
    return Math.min(uniqueTypes, maxEat);
};