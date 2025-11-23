function isAdditiveNumber(num) {
    const n = num.length;
    for (let i = 1; i < n; i++) {
        if (num[0] === '0' && i > 1) break;
        const first = num.substring(0, i);
        for (let j = i + 1; j < n; j++) {
            if (num[i] === '0' && j > i + 1) break;
            const second = num.substring(i, j);
            if (isValid(first, second, num.substring(j))) return true;
        }
    }
    return false;

    function isValid(first, second, remaining) {
        while (remaining) {
            const sum = (BigInt(first) + BigInt(second)).toString();
            if (remaining.startsWith(sum)) {
                first = second;
                second = sum;
                remaining = remaining.substring(sum.length);
            } else {
                return false;
            }
        }
        return true;
    }
}