function findMaxToys(toys, k) {
    toys.sort((a, b) => a - b);
    let maxToys = 0;
    let totalCost = 0;
    for (let i = 0; i < toys.length; i++) {
        if (totalCost + toys[i] <= k) {
            totalCost += toys[i];
            maxToys++;
        } else {
            break;
        }
    }
    return maxToys;
}