var nthMagicalNumber = function(n, a, b) {
    const MOD = 10**9 + 7;
    const lcm = (a * b) / gcd(a, b);

    let low = Math.min(a, b);
    let high = low * n;

    while (low < high) {
        const mid = Math.floor((low + high) / 2);
        const count = Math.floor(mid / a) + Math.floor(mid / b) - Math.floor(mid / lcm);

        if (count < n) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return low % MOD;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};