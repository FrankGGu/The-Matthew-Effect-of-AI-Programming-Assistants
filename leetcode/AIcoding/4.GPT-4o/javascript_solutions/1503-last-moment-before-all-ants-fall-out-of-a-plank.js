var getLastMoment = function(n, left, right) {
    let maxLeft = left.length > 0 ? Math.max(...left) : 0;
    let maxRight = right.length > 0 ? Math.max(...right) : 0;
    return Math.max(n - maxRight, maxLeft);
};