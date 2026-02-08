var nthMagicalNumber = function(n, a, b) {
    const MOD = 1e9 + 7;
    const lcm = (a * b) / gcd(a, b);

    let left = 0, right = 1e18;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let count = Math.floor(mid / a) + Math.floor(mid / b) - Math.floor(mid / lcm);
        if (count < n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left % MOD;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}