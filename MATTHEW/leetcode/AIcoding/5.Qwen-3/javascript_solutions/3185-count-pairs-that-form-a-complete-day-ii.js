function countCompleteDayPairs(timePoints) {
    const MOD = 24 * 60;
    const count = new Array(MOD).fill(0);
    for (const t of timePoints) {
        const min = t % MOD;
        count[min]++;
    }
    let result = 0;
    for (let i = 0; i < MOD; i++) {
        if (count[i] === 0) continue;
        for (let j = i + 1; j < MOD; j++) {
            if ((i + j) % MOD === 0) {
                result += count[i] * count[j];
            }
        }
    }
    return result;
}