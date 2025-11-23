var getLastMoment = function(n, left, right) {
    let maxTime = 0;

    for (let i = 0; i < left.length; i++) {
        maxTime = Math.max(maxTime, left[i]);
    }

    for (let i = 0; i < right.length; i++) {
        maxTime = Math.max(maxTime, n - right[i]);
    }

    return maxTime;
};