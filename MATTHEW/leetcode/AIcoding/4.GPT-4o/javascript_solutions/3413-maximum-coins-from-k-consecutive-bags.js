function maxCoins(bags, k) {
    bags.sort((a, b) => b - a);
    let maxCoins = 0;
    for (let i = 0; i < k; i++) {
        maxCoins += bags[i];
    }
    return maxCoins;
}