var minPatches = function(coins, n) {
    coins.sort((a, b) => a - b);

    let patches = 0;
    let currentMaxReachable = 0;
    let i = 0;

    while (currentMaxReachable < n) {
        if (i < coins.length && coins[i] <= currentMaxReachable + 1) {
            currentMaxReachable += coins[i];
            i++;
        } else {
            patches++;
            currentMaxReachable += (currentMaxReachable + 1);
        }
    }

    return patches;
};