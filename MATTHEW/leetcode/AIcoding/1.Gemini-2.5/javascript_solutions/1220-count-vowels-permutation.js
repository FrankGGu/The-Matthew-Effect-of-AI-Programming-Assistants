var countVowelPermutation = function(n) {
    const MOD = 10**9 + 7;

    let prev_a = 1;
    let prev_e = 1;
    let prev_i = 1;
    let prev_o = 1;
    let prev_u = 1;

    for (let k = 2; k <= n; k++) {
        let current_a = 0;
        let current_e = 0;
        let current_i = 0;
        let current_o = 0;
        let current_u = 0;

        // A string ending in 'a' can be formed by appending 'a' to strings ending in 'e', 'i', or 'u'.
        // (because 'e' can be followed by 'a', 'i' can be followed by 'a', 'u' can be followed by 'a')
        current_a = (prev_e + prev_i + prev_u) % MOD;

        // A string ending in 'e' can be formed by appending 'e' to strings ending in 'a' or 'i'.
        // (because 'a' can be followed by 'e', 'i' can be followed by 'e')
        current_e = (prev_a + prev_i) % MOD;

        // A string ending in 'i' can be formed by appending 'i' to strings ending in 'e' or 'o'.
        // (because 'e' can be followed by 'i', 'o' can be followed by 'i')
        current_i = (prev_e + prev_o) % MOD;

        // A string ending in 'o' can be formed by appending 'o' to strings ending in 'i'.
        // (because 'i' can be followed by 'o')
        current_o = prev_i % MOD;

        // A string ending in 'u' can be formed by appending 'u' to strings ending in 'i' or 'o'.
        // (because 'i' can be followed by 'u', 'o' can be followed by 'u')
        current_u = (prev_i + prev_o) % MOD;

        prev_a = current_a;
        prev_e = current_e;
        prev_i = current_i;
        prev_o = current_o;
        prev_u = current_u;
    }

    return (prev_a + prev_e + prev_i + prev_o + prev_u) % MOD;
};