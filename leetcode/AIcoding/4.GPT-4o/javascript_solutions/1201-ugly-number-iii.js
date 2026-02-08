var nthUglyNumber = function(n, a, b, c) {
    const gcd = (x, y) => y === 0 ? x : gcd(y, x % y);
    const lcm = (x, y) => (x * y) / gcd(x, y);

    const lcmAB = lcm(a, b);
    const lcmAC = lcm(a, c);
    const lcmBC = lcm(b, c);
    const lcmABC = lcm(lcmAB, c);

    const countUgly = x => Math.floor(x / a) + Math.floor(x / b) + Math.floor(x / c)
        - Math.floor(x / lcmAB) - Math.floor(x / lcmAC) - Math.floor(x / lcmBC)
        + Math.floor(x / lcmABC);

    let left = 1, right = 2 * 10**9;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (countUgly(mid) < n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};