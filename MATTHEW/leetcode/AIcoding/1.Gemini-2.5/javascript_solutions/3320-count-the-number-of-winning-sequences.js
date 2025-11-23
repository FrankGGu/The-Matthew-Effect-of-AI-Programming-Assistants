var countWinningSequences = function(time, distance) {
    let totalWays = 1;

    for (let i = 0; i < time.length; i++) {
        const T = time[i];
        const D = distance[i];

        const delta = T * T - 4 * D;

        if (delta <= 0) {
            totalWays *= 0;
            break;
        }

        const sqrtDelta = Math.sqrt(delta);
        const r1 = (T - sqrtDelta) / 2;
        const r2 = (T + sqrtDelta) / 2;

        const minH = Math.floor(r1) + 1;
        const maxH = Math.ceil(r2) - 1;

        let waysForRace = 0;
        if (minH <= maxH) {
            waysForRace = maxH - minH + 1;
        }

        totalWays *= waysForRace;
    }

    return totalWays;
};