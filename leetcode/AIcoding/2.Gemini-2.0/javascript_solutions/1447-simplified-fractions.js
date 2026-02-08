var simplifiedFractions = function(n) {
    const result = [];
    for (let i = 2; i <= n; i++) {
        for (let j = 1; j < i; j++) {
            if (gcd(i, j) === 1) {
                result.push(j + "/" + i);
            }
        }
    }
    return result;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};