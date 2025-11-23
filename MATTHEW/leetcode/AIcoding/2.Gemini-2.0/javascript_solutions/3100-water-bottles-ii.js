var canMeasureWater = function(capacity1, capacity2, target) {
    if (target > capacity1 + capacity2) return false;
    if (target === 0) return true;
    if (capacity1 === 0 && capacity2 === 0) return target === 0;

    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let commonDivisor = gcd(capacity1, capacity2);
    return target % commonDivisor === 0;
};