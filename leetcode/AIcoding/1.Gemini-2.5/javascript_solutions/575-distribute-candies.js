var distributeCandies = function(candyType) {
    const uniqueCandies = new Set(candyType);
    const maxCandiesToEat = candyType.length / 2;

    return Math.min(uniqueCandies.size, maxCandiesToEat);
};