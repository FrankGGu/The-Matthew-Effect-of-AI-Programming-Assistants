var nthUglyNumber = function(n, a, b, c) {
    function bigIntGcd(x, y) {
        x = BigInt(x);
        y = BigInt(y);
        while (y > 0n) {
            [x, y] = [y, x % y];
        }
        return x;
    }

    function bigIntLcm(x, y) {
        if (x === 0n || y === 0n) return 0n;
        const commonDivisor = bigIntGcd(x, y);
        return (x / commonDivisor) * y;
    }

    function countUglyNumbers(num, a, b, c) {
        const bigA = BigInt(a);
        const bigB = BigInt(b);
        const bigC = BigInt(c);

        const countA = num / bigA;
        const countB = num / bigB;
        const countC = num / bigC;

        const countAB = num / bigIntLcm(bigA, bigB);
        const countAC = num / bigIntLcm(bigA, bigC);
        const countBC = num / bigIntLcm(bigB, bigC);

        const lcmABC = bigIntLcm(bigIntLcm(bigA, bigB), bigC);
        const countABC = num / lcmABC;

        return countA + countB + countC - countAB - countAC - countBC + countABC;
    }

    let low = 1n;
    let high = 2_000_000_000_000_000_000n; // A sufficiently large upper bound (2 * 10^18)
    let ans = high;

    while (low <= high) {
        let mid = low + (high - low) / 2n;
        if (countUglyNumbers(mid, a, b, c) >= BigInt(n)) {
            ans = mid;
            high = mid - 1n;
        } else {
            low = mid + 1n;
        }
    }

    return Number(ans);
};