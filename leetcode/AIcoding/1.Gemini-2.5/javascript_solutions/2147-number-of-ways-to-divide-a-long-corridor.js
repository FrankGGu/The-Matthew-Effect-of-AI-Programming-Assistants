var numberOfWays = function(corridor) {
    const seatIndices = [];
    for (let i = 0; i < corridor.length; i++) {
        if (corridor[i] === 'S') {
            seatIndices.push(i);
        }
    }

    const seatCount = seatIndices.length;

    if (seatCount === 0 || seatCount % 2 !== 0) {
        return 0;
    }

    let ways = 1;
    const MOD = 1_000_000_007;

    for (let i = 1; i < seatCount - 1; i += 2) {
        const gap = seatIndices[i+1] - seatIndices[i];
        ways = (ways * gap) % MOD;
    }

    return ways;
};