var numberOfWays = function(corridor) {
    const MOD = 1000000007;
    let seats = 0;
    for (let i = 0; i < corridor.length; i++) {
        if (corridor[i] === 'S') {
            seats++;
        }
    }

    if (seats < 2 || seats % 2 !== 0) {
        return 0;
    }

    let ways = 1;
    let seatCount = 0;
    let plants = 0;

    for (let i = 0; i < corridor.length; i++) {
        if (corridor[i] === 'S') {
            seatCount++;
            if (seatCount > 2 && seatCount % 2 === 1) {
                ways = (ways * (plants + 1)) % MOD;
                plants = 0;
            }
        } else if (seatCount === 2) {
            plants++;
        }
    }

    return ways;
};