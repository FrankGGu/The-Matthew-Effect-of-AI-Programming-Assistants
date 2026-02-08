var countWays = function(ranges) {
    ranges.sort((a, b) => a[0] - b[0]);

    let numDisjointGroups = 0;
    let currentMaxEnd = -1;

    for (let i = 0; i < ranges.length; i++) {
        const [start, end] = ranges[i];

        if (start > currentMaxEnd) {
            numDisjointGroups++;
            currentMaxEnd = end;
        } else {
            currentMaxEnd = Math.max(currentMaxEnd, end);
        }
    }

    const MOD = 10**9 + 7;

    let result = 1;
    let base = 2;
    let exponent = numDisjointGroups;

    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exponent = Math.floor(exponent / 2);
    }

    return result;
};