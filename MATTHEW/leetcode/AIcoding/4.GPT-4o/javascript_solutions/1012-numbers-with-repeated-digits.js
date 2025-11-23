var numDupDigitsAtMostN = function(N) {
    const strN = String(N);
    const len = strN.length;
    const count = Array(10).fill(0);
    let res = 0;

    for (let i = 0; i < len; i++) {
        const currentDigit = strN[i] - '0';
        for (let j = (i === 0 ? 1 : 0); j < currentDigit; j++) {
            if (count[j] === 0) {
                res += Math.pow(10, len - i - 1);
            }
        }
        if (count[currentDigit] > 0) {
            break;
        }
        count[currentDigit]++;
        if (i === len - 1) {
            res++;
        }
    }

    return N - res;
};