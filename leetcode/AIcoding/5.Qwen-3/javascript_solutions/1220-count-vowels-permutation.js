function countVowels(n) {
    const MOD = 1000000007;
    let a = 1, e = 1, i = 1, o = 1, u = 1;
    for (let j = 2; j <= n; j++) {
        let newA = (e + i + u) % MOD;
        let newE = (a + i) % MOD;
        let newI = (e + o) % MOD;
        let newO = (i) % MOD;
        let newU = (i + o) % MOD;
        a = newA;
        e = newE;
        i = newI;
        o = newO;
        u = newU;
    }
    return (a + e + i + o + u) % MOD;
}