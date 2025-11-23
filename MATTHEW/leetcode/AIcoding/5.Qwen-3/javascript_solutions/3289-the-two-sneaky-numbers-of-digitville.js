function findCandies(candyType) {
    const set = new Set();
    for (const type of candyType) {
        set.add(type);
    }
    return set.size;
}