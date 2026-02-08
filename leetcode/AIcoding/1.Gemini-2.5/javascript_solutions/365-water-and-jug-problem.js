var canMeasureWater = function(jug1Capacity, jug2Capacity, targetCapacity) {
    if (targetCapacity === 0) {
        return true;
    }

    if (targetCapacity > jug1Capacity + jug2Capacity) {
        return false;
    }

    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    const commonDivisor = gcd(jug1Capacity, jug2Capacity);

    return targetCapacity % commonDivisor === 0;
};