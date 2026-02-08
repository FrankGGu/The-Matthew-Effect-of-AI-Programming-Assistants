var canMeasureWater = function(jug1Capacity, jug2Capacity, targetCapacity) {
    if (targetCapacity > jug1Capacity + jug2Capacity) return false;
    if (targetCapacity === 0) return true;
    if (jug1Capacity === 0 && jug2Capacity === 0) return targetCapacity === 0;

    function gcd(a, b) {
        while (b) {
            const temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    const commonDivisor = gcd(jug1Capacity, jug2Capacity);

    return targetCapacity % commonDivisor === 0;
};