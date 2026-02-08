function minimumDamage(health, armor, attacks) {
    let totalDamage = 0;
    let totalArmorDamage = 0;

    for (const [damage, type] of attacks) {
        if (type === 'physical') {
            totalDamage += damage;
        } else {
            totalArmorDamage += damage;
        }
    }

    totalDamage = Math.max(totalDamage - armor, 0) + totalArmorDamage;
    return Math.min(totalDamage, health);
}