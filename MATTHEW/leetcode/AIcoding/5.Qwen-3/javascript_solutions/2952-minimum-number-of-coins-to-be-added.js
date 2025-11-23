function minimumCoins(coins, target) {
    coins.sort((a, b) => a - b);
    let res = 0;
    let current = 0;
    for (let coin of coins) {
        while (current + 1 < coin) {
            res++;
            current += current + 1;
        }
        current += coin;
    }
    while (current < target) {
        res++;
        current += current + 1;
    }
    return res;
}