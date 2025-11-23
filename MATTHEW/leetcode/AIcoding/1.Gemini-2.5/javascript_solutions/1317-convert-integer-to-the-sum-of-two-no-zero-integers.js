var getNoZeroIntegers = function(n) {
    const hasZero = (num) => {
        return String(num).includes('0');
    };

    for (let i = 1; i < n; i++) {
        let a = i;
        let b = n - i;
        if (!hasZero(a) && !hasZero(b)) {
            return [a, b];
        }
    }
};