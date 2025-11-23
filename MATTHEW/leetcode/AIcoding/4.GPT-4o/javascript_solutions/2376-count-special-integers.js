var countSpecialNumbers = function(n) {
    const digits = String(n).split('').map(Number);
    const len = digits.length;
    let count = 0;

    for (let i = 1; i < len; i++) {
        count += 9 * permute(9, i - 1);
    }

    let seen = new Set();
    for (let i = 0; i < len; i++) {
        for (let j = (i === 0 ? 1 : 0); j < digits[i]; j++) {
            if (!seen.has(j)) {
                count += permute(9 - i, len - 1 - i);
            }
        }
        if (seen.has(digits[i])) {
            break;
        }
        seen.add(digits[i]);
    }

    return count + 1;
};

function permute(n, k) {
    let res = 1;
    for (let i = 0; i < k; i++) {
        res *= n - i;
    }
    return res;
}