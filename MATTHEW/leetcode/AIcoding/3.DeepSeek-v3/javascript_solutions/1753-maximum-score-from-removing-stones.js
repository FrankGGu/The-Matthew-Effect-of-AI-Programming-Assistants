var maximumScore = function(a, b, c) {
    const max = Math.max(a, b, c);
    const sum = a + b + c;
    if (sum - max <= max) {
        return sum - max;
    } else {
        return Math.floor(sum / 2);
    }
};