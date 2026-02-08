var getLastMoment = function(n, left, right) {
    let maxLeft = 0;
    for (let i = 0; i < left.length; i++) {
        maxLeft = Math.max(maxLeft, left[i]);
    }

    let maxRight = 0;
    for (let i = 0; i < right.length; i++) {
        maxRight = Math.max(maxRight, n - right[i]);
    }

    return Math.max(maxLeft, maxRight);
};