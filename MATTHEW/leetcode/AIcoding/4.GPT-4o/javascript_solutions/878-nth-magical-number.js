var nthMagicalNumber = function(n, a, b) {
    const MOD = 1000000007;
    const lcm = (a * b) / gcd(a, b);
    const countInLcm = (lcm / a) + (lcm / b) - 1;
    const fullSets = Math.floor(n / countInLcm);
    const remaining = n % countInLcm;

    let result = (fullSets * lcm) % MOD;
    let aCount = 0, bCount = 0;

    for (let i = 0; i < remaining; i++) {
        if (aCount * b < bCount * a) {
            result = (result + a) % MOD;
            aCount++;
        } else {
            result = (result + b) % MOD;
            bCount++;
        }
    }

    return result;
};

function gcd(x, y) {
    while (y !== 0) {
        [x, y] = [y, x % y];
    }
    return x;
}