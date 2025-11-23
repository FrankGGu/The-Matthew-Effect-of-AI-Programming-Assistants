var maximumDamage = function(damage, armor) {
    let totalDamage = damage.reduce((a, b) => a + b, 0);
    let maxDamageReduction = Math.min(Math.max(...damage), armor);
    return totalDamage - maxDamageReduction;
};