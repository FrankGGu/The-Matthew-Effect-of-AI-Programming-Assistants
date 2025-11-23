var maximumXorProduct = function(a, b, n) {
    let mod = 10**9 + 7;
    let x = 0;
    for (let i = n - 1; i >= 0; i--) {
        let bit = 1 << i;
        if ((a & bit) === (b & bit)) {
            if (a < b) {
                a |= bit;
            } else {
                b |= bit;
            }
        } else {
            if (a > b) {
                if ((x | bit) <= (a & ~bit)) {
                    a &= ~bit;
                    x |= bit;
                } else if ((x | bit) <= (b | bit)){
                    b |= bit;
                    x |= bit;
                }
            } else {
                if ((x | bit) <= (b & ~bit)) {
                    b &= ~bit;
                    x |= bit;
                } else if ((x | bit) <= (a | bit)){
                    a |= bit;
                    x |= bit;
                }
            }
        }
    }

    return (BigInt(a) * BigInt(b)) % BigInt(mod);
};