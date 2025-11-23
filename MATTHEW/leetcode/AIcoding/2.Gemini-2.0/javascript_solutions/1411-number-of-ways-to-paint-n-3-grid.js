var numOfWays = function(n) {
    let type1 = 6; // Number of ways to paint with pattern ABC or ABA
    let type2 = 6; // Number of ways to paint with pattern ABB or AAB

    const MOD = 10**9 + 7;

    for (let i = 1; i < n; i++) {
        let newType1 = (type1 * 3 + type2 * 2) % MOD;
        let newType2 = (type1 * 2 + type2 * 2) % MOD;

        type1 = newType1;
        type2 = newType2;
    }

    return (type1 + type2) % MOD;
};