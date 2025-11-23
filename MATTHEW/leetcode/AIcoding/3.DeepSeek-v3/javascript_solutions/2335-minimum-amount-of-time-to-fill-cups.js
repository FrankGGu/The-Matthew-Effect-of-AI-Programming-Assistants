var fillCups = function(amount) {
    let max = Math.max(...amount);
    let sum = amount.reduce((a, b) => a + b, 0);
    return Math.max(max, Math.ceil(sum / 2));
};