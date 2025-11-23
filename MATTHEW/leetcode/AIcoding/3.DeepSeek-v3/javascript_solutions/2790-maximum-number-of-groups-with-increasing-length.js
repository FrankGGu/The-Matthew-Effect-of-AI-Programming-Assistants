var maxIncreasingGroups = function(usageLimits) {
    usageLimits.sort((a, b) => a - b);
    let total = 0;
    let res = 0;
    for (const num of usageLimits) {
        total += num;
        if (total >= (res + 1) * (res + 2) / 2) {
            res++;
        }
    }
    return res;
};