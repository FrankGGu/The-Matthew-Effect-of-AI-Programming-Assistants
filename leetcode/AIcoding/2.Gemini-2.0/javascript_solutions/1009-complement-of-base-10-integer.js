var bitwiseComplement = function(n) {
    if (n === 0) return 1;
    let x = 1;
    while (x <= n) {
        x = x * 2;
    }
    return x - 1 - n;
};