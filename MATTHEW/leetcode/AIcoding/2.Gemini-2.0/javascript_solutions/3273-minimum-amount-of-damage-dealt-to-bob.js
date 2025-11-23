var minDamage = function(bobHealth, aliceAttack, bobDefense) {
    let n = bobHealth.length;
    let minTotalDamage = Infinity;

    for (let i = 0; i < (1 << n); i++) {
        let currentHealth = [...bobHealth];
        let totalDamage = 0;
        let currentDefense = 0;

        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                currentDefense += 1;
            }
        }

        for (let j = 0; j < n; j++) {
            let damage = Math.max(0, aliceAttack[j] - (bobDefense[j] + currentDefense));
            totalDamage += damage;
        }

        minTotalDamage = Math.min(minTotalDamage, totalDamage);
    }

    return minTotalDamage;
};