const waysToFillArray = function(queries) {
    const MOD = 1e9 + 7;
    const maxK = 10000;
    const maxLog = 14;

    // Precompute smallest prime factors (spf) for numbers up to maxK
    const spf = new Array(maxK + 1).fill(0);
    for (let i = 2; i <= maxK; i++) {
        if (spf[i] === 0) {
            spf[i] = i;
            for (let j = i * i; j <= maxK; j += i) {
                if (spf[j] === 0) spf[j] = i;
            }
        }
    }

    // Precompute combination numbers C(n + k - 1, k) for k up to maxLog and n up to maxK
    const comb = Array.from({ length: maxK + maxLog }, () => new Array(maxLog + 1).fill(0));
    for (let n = 0; n < comb.length; n++) {
        comb[n][0] = 1;
        if (n <= maxLog) comb[n][n] = 1;
        for (let k = 1; k < n && k <= maxLog; k++) {
            comb[n][k] = (comb[n - 1][k - 1] + comb[n - 1][k]) % MOD;
        }
    }

    const factorize = (x) => {
        const factors = {};
        while (x > 1) {
            const p = spf[x];
            factors[p] = (factors[p] || 0) + 1;
            x /= p;
        }
        return factors;
    };

    const res = [];
    for (const [n, k] of queries) {
        const factors = factorize(k);
        let total = 1;
        for (const p in factors) {
            const cnt = factors[p];
            total = (total * comb[n + cnt - 1][cnt]) % MOD;
        }
        res.push(total);
    }
    return res;
};