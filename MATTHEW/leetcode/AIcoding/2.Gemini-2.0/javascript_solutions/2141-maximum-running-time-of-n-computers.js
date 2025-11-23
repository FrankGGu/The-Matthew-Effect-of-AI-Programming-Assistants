var maxRunTime = function(n, batteries) {
    batteries.sort((a, b) => a - b);
    let sum = batteries.reduce((acc, curr) => acc + curr, 0);
    let k = batteries.length - 1;

    while (batteries[k] > Math.floor(sum / n)) {
        sum -= batteries[k];
        n--;
        k--;
    }

    return Math.floor(sum / n);
};