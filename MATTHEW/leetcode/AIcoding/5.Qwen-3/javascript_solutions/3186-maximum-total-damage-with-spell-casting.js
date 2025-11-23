function maximumTotalDamage(power) {
    const damageMap = new Map();
    for (const p of power) {
        damageMap.set(p, (damageMap.get(p) || 0) + 1);
    }

    const sortedDamages = Array.from(damageMap.keys()).sort((a, b) => a - b);
    const n = sortedDamages.length;
    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let maxDamage = damageMap.get(sortedDamages[i]) * sortedDamages[i];
        for (let j = 0; j < i; j++) {
            if (sortedDamages[i] - sortedDamages[j] > 1) {
                maxDamage = Math.max(maxDamage, dp[j] + damageMap.get(sortedDamages[i]) * sortedDamages[i]);
            }
        }
        dp[i] = maxDamage;
    }

    return Math.max(...dp);
}