var minimumAddedCoins = function(coins, target) {
    coins.sort((a, b) => a - b);
    let res = 0;
    let reach = 0;
    let i = 0;
    const n = coins.length;

    while (reach < target) {
        if (i < n && coins[i] <= reach + 1) {
            reach += coins[i];
            i++;
        } else {
            res++;
            reach += reach + 1;
        }
    }

    return res;
};