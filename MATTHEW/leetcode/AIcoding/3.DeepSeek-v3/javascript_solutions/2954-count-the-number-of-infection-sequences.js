const MOD = 1e9 + 7;

function countInfectionSequences(n, sick) {
    const fact = new Array(n + 1).fill(1);
    const invFact = new Array(n + 1).fill(1);

    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    invFact[n] = modInverse(fact[n], MOD);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }

    sick.sort((a, b) => a - b);
    let total = 1;
    let sum = 0;

    const gaps = [];
    if (sick[0] > 0) {
        gaps.push(sick[0] - 1);
    }

    for (let i = 1; i < sick.length; i++) {
        const gap = sick[i] - sick[i - 1] - 1;
        if (gap > 0) {
            gaps.push(gap);
        }
    }

    if (sick[sick.length - 1] < n - 1) {
        gaps.push(n - sick[sick.length - 1] - 1);
    }

    sum = n - sick.length;

    for (const gap of gaps) {
        total = (total * fact[sum]) % MOD;
        total = (total * invFact[gap]) % MOD;
        total = (total * invFact[sum - gap]) % MOD;
        sum -= gap;
    }

    for (let i = 1; i < sick.length; i++) {
        const gap = sick[i] - sick[i - 1] - 1;
        if (gap > 1) {
            total = (total * power(2, gap - 1, MOD)) % MOD;
        }
    }

    return total;
}

function modInverse(a, mod) {
    let b = mod;
    let [x, y, u, v] = [0, 1, 1, 0];
    while (a !== 0) {
        const q = Math.floor(b / a);
        [x, y, u, v] = [u, v, x - u * q, y - v * q];
        [a, b] = [b % a, a];
    }
    return (x % mod + mod) % mod;
}

function power(a, b, mod) {
    let res = 1;
    a = a % mod;
    while (b > 0) {
        if (b % 2 === 1) {
            res = (res * a) % mod;
        }
        a = (a * a) % mod;
        b = Math.floor(b / 2);
    }
    return res;
}