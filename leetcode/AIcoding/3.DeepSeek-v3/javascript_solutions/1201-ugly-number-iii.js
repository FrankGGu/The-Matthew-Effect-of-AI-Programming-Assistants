var nthUglyNumber = function(n, a, b, c) {
    const gcd = (x, y) => {
        while (y) {
            [x, y] = [y, x % y];
        }
        return x;
    };

    const lcm = (x, y) => (x * y) / gcd(x, y);

    const countUgly = (num) => {
        return Math.floor(num / a) + Math.floor(num / b) + Math.floor(num / c) 
            - Math.floor(num / lcm(a, b)) 
            - Math.floor(num / lcm(a, c)) 
            - Math.floor(num / lcm(b, c)) 
            + Math.floor(num / lcm(a, lcm(b, c)));
    };

    let left = 1, right = 2 * 1e9;
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