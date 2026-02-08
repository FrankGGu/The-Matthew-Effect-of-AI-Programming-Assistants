function getMaximumConsecutive(coins) {
    coins.sort((a, b) => a - b);
    let max = 0;
    for (let i = 0; i < coins.length; i++) {
        if (coins[i] <= max + 1) {
            max += coins[i];
        } else {
            break;
        }
    }
    return max + 1;
}