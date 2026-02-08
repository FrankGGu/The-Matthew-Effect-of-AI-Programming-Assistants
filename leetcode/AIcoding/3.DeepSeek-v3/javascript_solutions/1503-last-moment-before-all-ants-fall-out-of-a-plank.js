var getLastMoment = function(n, left, right) {
    let maxLeft = left.length ? Math.max(...left) : 0;
    let minRight = right.length ? Math.min(...right) : n;
    return Math.max(maxLeft, n - minRight);
};