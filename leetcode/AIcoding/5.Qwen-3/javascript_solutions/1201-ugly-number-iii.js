function nthUglyNumber(n, a, b, c) {
    let left = 1;
    let right = Math.pow(2, 31) - 1;

    const lcm = (x, y) => x * y / gcd(x, y);
    const gcd = (x, y) => y === 0 ? x : gcd(y, x % y);

    const count = (num) => {
        const ab = lcm(a, b);
        const ac = lcm(a, c);
        const bc = lcm(b, c);
        const abc = lcm(ab, c);
        return Math.floor(num / a) + Math.floor(num / b) + Math.floor(num / c) - Math.floor(num / ab) - Math.floor(num / ac) - Math.floor(num / bc) + Math.floor(num / abc);
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (count(mid) < n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}