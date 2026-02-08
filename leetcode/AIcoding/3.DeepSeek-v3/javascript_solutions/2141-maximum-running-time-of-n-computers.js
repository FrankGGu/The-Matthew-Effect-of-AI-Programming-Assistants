var maxRunTime = function(n, batteries) {
    batteries.sort((a, b) => a - b);
    let sum = batteries.reduce((a, b) => a + b, 0);
    let k = 0, len = batteries.length;
    while (batteries[len - 1 - k] > sum / (n - k)) {
        sum -= batteries[len - 1 - k];
        k++;
    }
    return Math.floor(sum / (n - k));
};