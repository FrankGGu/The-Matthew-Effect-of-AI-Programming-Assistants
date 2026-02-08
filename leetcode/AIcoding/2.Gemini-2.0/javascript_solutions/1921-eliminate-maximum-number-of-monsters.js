var eliminateMaximum = function(dist, speed) {
    const n = dist.length;
    const arrivalTimes = [];
    for (let i = 0; i < n; i++) {
        arrivalTimes.push(Math.ceil(dist[i] / speed[i]));
    }
    arrivalTimes.sort((a, b) => a - b);
    let eliminated = 0;
    for (let i = 0; i < n; i++) {
        if (arrivalTimes[i] <= i) {
            break;
        }
        eliminated++;
    }
    return eliminated;
};