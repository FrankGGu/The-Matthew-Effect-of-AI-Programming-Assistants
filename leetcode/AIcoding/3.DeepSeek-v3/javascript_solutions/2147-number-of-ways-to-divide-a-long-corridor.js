var numberOfWays = function(corridor) {
    const MOD = 1e9 + 7;
    let seats = 0;
    let plants = 0;
    let result = 1;

    for (const char of corridor) {
        if (char === 'S') {
            seats++;
            if (seats % 2 === 0) {
                result = (result * (plants + 1)) % MOD;
                plants = 0;
            }
        } else if (seats > 0 && seats % 2 === 0) {
            plants++;
        }
    }

    return seats % 2 === 0 && seats > 0 ? result : 0;
};