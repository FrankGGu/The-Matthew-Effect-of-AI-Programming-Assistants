function distributeCandies(candyType) {
    const uniqueCandies = new Set(candyType);
    const maxTypes = Math.min(uniqueCandies.size, Math.floor(candyType.length / 2));
    return maxTypes;
}