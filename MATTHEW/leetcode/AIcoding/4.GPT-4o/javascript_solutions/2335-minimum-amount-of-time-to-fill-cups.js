var fillCups = function(cups) {
    let max = Math.max(...cups);
    let sum = cups.reduce((a, b) => a + b, 0);
    return Math.max(max, Math.ceil(sum / 2));
};