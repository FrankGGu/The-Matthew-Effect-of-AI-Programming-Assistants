var minOperations = function(coins) {
    let totalOperations = 0;
    for (let i = 0; i < coins.length; i++) {
        totalOperations += Math.ceil(coins[i] / 2);
    }
    return totalOperations;
};