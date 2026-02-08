function getNoZeroIntegers(n) {
    for (let i = 1; i < n; i++) {
        let j = n - i;
        if (!String(i).includes('0') && !String(j).includes('0')) {
            return [i, j];
        }
    }
    return [];
}