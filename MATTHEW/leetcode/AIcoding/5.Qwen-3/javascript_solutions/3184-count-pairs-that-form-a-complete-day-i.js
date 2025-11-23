function countCompleteDayPairs(timePoints) {
    const MOD = 24 * 60;
    const count = new Map();
    let result = 0;

    for (const time of timePoints) {
        const remainder = time % MOD;
        const complement = (MOD - remainder) % MOD;
        result += count.get(complement) || 0;
        count.set(remainder, (count.get(remainder) || 0) + 1);
    }

    return result;
}