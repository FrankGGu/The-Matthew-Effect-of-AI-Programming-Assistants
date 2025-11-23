var findMinimumTime = function(time) {
    time.sort((a, b) => a - b);
    let res = 0;
    for (let i = 0; i < time.length; i++) {
        if (i === 0 || time[i] > time[i - 1]) {
            res += time[i];
        }
    }
    return res;
};