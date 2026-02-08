var nthUglyNumber = function(n, a, b, c) {
    const lcmAB = lcm(a, b);
    const lcmAC = lcm(a, c);
    const lcmBC = lcm(b, c);
    const lcmABC = lcm(lcmAB, c);

    let low = 1;
    let high = 2 * 10 ** 9;

    while (low < high) {
        const mid = Math.floor(low + (high - low) / 2);
        const count = Math.floor(mid / a) + Math.floor(mid / b) + Math.floor(mid / c) -
                      Math.floor(mid / lcmAB) - Math.floor(mid / lcmAC) - Math.floor(mid / lcmBC) +
                      Math.floor(mid / lcmABC);

        if (count < n) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return low;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    function lcm(a, b) {
        return (a * b) / gcd(a, b);
    }
};