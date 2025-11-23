var canMeasureWater = function(jug1Capacity, jug2Capacity, targetCapacity) {
    if (jug1Capacity + jug2Capacity < targetCapacity) return false;
    if (jug1Capacity === targetCapacity || jug2Capacity === targetCapacity || jug1Capacity + jug2Capacity === targetCapacity) return true;

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    return targetCapacity % gcd(jug1Capacity, jug2Capacity) === 0;
};