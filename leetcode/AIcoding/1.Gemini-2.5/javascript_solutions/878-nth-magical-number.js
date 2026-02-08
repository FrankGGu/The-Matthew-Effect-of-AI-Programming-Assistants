var nthMagicalNumber = function(n, a, b) {
    const N = BigInt(n);
    const A = BigInt(a);
    const B = BigInt(b);
    const MOD = 1000000007n;

    const gcd = (x, y) => {
        while (y !== 0n) {
            const temp = y;
            y = x % y;
            x = temp;
        }
        return x;
    };

    const lcm = (x, y) => {
        if (x === 0n || y === 0n) return 0n;
        return (x * y) / gcd(x, y);
    };

    const LCM_AB = lcm(A, B);

    const countMagical = (num) => {
        return num / A + num / B - num / LCM_AB;
    };

    let low = 1n;
    let high = N * BigInt(Math.max(a, b));
    let ans = high;

    while (low <= high) {
        let mid = low + (high - low) / 2n;
        if (countMagical(mid) >= N) {
            ans = mid;
            high = mid - 1n;
        } else {
            low = mid + 1n;
        }
    }

    return Number(ans % MOD);
};