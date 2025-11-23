var getMinimumTime = function(time, fruits, limit) {
    let totalTime = 0;
    for (const [type, amount] of fruits) {
        const t = time[type];
        const batches = Math.ceil(amount / limit);
        totalTime += batches * t;
    }
    return totalTime;
};