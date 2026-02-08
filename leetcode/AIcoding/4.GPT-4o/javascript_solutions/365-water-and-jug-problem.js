var canMeasureWater = function(jug1Capacity, jug2Capacity, targetCapacity) {
    if (targetCapacity > jug1Capacity + jug2Capacity) return false;
    if (targetCapacity === 0) return true;

    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    return targetCapacity % gcd(jug1Capacity, jug2Capacity) === 0;
};