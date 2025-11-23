const MOD = 10 ** 9 + 7;

const fact = [];
const invFact = [];
let maxNInitialized = 0;

function power(base, exp) {
    let res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 === 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp = Math.floor(exp / 2);
    }
    return res;
}

function initFactorials(n) {
    if (n <= maxNInitialized) {
        return;
    }

    if (maxNInitialized === 0) {
        fact[0] = 1;
        invFact[0] = 1; // 0! = 1, and its inverse is 1
    }

    for (let i = maxNInitialized + 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    invFact[n] = power(fact[n], MOD - 2); // Calculate inverse of n! using Fermat's Little Theorem
    for (let i = n - 1; i > maxNInitialized; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }

    maxNInitialized = n;
}

var numberOfSequence = function(n, infected_people) {
    const m = infected_people.length;

    if (m === n) {
        return 1;
    }

    const totalUninfected = n - m;

    initFactorials(n);

    let ans = 1;
    const segmentLengths = [];

    const lenLeft = infected_people[0];
    if (lenLeft > 0) {
        segmentLengths.push(lenLeft);
    }

    for (let i = 0; i < m - 1; i++) {
        const lenMiddle = infected_people[i + 1] - infected_people[i] - 1;
        if (lenMiddle > 0) {
            ans = (ans * power(2, lenMiddle - 1)) % MOD;
            segmentLengths.push(lenMiddle);
        }
    }

    const lenRight = n - 1 - infected_people[m - 1];
    if (lenRight > 0) {
        segmentLengths.push(lenRight);
    }

    ans = (ans * fact[totalUninfected]) % MOD;

    for (const len of segmentLengths) {
        ans = (ans * invFact[len]) % MOD;
    }

    return ans;
};