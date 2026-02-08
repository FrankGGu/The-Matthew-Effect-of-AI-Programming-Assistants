var countVowelPermutation = function(n) {
    const MOD = 10**9 + 7;
    let a = 1, e = 1, i = 1, o = 1, u = 1;
    for (let j = 1; j < n; j++) {
        let a_new = (e + i + u) % MOD;
        let e_new = (a + i) % MOD;
        let i_new = (e + o) % MOD;
        let o_new = i;
        let u_new = (i + o) % MOD;
        a = a_new;
        e = e_new;
        i = i_new;
        o = o_new;
        u = u_new;
    }
    return (a + e + i + o + u) % MOD;
};