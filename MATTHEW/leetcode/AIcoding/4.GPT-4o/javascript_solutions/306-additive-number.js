var isAdditiveNumber = function(num) {
    const isValid = (first, second, remaining) => {
        if (!remaining) return true;
        const sum = String(BigInt(first) + BigInt(second));
        if (remaining.startsWith(sum)) {
            return isValid(second, sum, remaining.slice(sum.length));
        }
        return false;
    };

    for (let i = 1; i < num.length; i++) {
        for (let j = i + 1; j < num.length; j++) {
            const first = num.slice(0, i);
            const second = num.slice(i, j);
            if ((first.length > 1 && first[0] === '0') || (second.length > 1 && second[0] === '0')) continue;
            if (isValid(first, second, num.slice(j))) return true;
        }
    }
    return false;
};