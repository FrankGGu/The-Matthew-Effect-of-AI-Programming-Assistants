var numOfWays = function(n) {
    const MOD = 1e9 + 7;
    let aba = 6, abc = 6;
    for (let i = 1; i < n; i++) {
        let newAba = (aba * 3 + abc * 2) % MOD;
        let newAbc = (aba * 2 + abc * 2) % MOD;
        aba = newAba;
        abc = newAbc;
    }
    return (aba + abc) % MOD;
};