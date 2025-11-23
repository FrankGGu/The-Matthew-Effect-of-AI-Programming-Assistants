function countAnagrams(s) {
    const MOD = 10 ** 9 + 7;
    const n = s.length;
    const fact = new Array(n + 1).fill(1);
    const invFact = new Array(n + 1).fill(1);

    for (let i = 2; i <= n; i++) {
        fact[i] = fact[i - 1] * i % MOD;
    }

    invFact[n] = pow(fact[n], MOD - 2, MOD);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = invFact[i + 1] * (i + 1) % MOD;
    }

    function pow(a, b, mod) {
        let result = 1;
        a = a % mod;
        while (b > 0) {
            if (b & 1) result = result * a % mod;
            a = a * a % mod;
            b >>= 1;
        }
        return result;
    }

    let result = 0;
    const freq = new Array(26).fill(0);
    let left = 0;

    for (let right = 0; right < n; right++) {
        freq[s.charCodeAt(right) - 'a'.charCodeAt(0)]++;
        while (true) {
            let valid = true;
            for (let i = 0; i < 26; i++) {
                if (freq[i] > 0 && freq[i] < 2) {
                    valid = false;
                    break;
                }
            }
            if (valid) break;
            freq[s.charCodeAt(left) - 'a'.charCodeAt(0)]--;
            left++;
        }
        result = (result + fact[right - left + 1]) % MOD;
    }

    return result;
}