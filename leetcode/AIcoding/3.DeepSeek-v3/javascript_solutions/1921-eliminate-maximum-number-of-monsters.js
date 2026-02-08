var eliminateMaximum = function(dist, speed) {
    const n = dist.length;
    const timeToReach = [];
    for (let i = 0; i < n; i++) {
        timeToReach.push(Math.ceil(dist[i] / speed[i]));
    }
    timeToReach.sort((a, b) => a - b);
    let eliminated = 0;
    for (let time = 0; time < n; time++) {
        if (time >= timeToReach[time]) {
            break;
        }
        eliminated++;
    }
    return eliminated;
};