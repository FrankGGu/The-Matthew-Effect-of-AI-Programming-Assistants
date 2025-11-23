function numberOfWays(corridor) {
    const MOD = 1000000007;
    let count = 0;
    let positions = [];
    for (let i = 0; i < corridor.length; i++) {
        if (corridor[i] === 'S') {
            positions.push(i);
        }
    }
    if (positions.length % 2 !== 0) return 0;
    let result = 1;
    for (let i = 2; i < positions.length; i += 2) {
        let prev = positions[i - 1];
        let curr = positions[i];
        let gap = curr - prev;
        result = (result * gap) % MOD;
    }
    return result;
}