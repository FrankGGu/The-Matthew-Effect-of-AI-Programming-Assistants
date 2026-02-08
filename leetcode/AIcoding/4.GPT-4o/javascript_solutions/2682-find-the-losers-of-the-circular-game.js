function findTheLosers(n, k) {
    const losers = Array.from({ length: n }, (_, i) => i + 1);
    let index = 0;

    while (losers.length > 1) {
        index = (index + k - 1) % losers.length;
        losers.splice(index, 1);
    }

    return losers;
}