function getSortedDigits(num) {
    return String(num).split('').sort().join('');
}

var reorderedPowerOf2 = function(n) {
    const nSortedDigits = getSortedDigits(n);

    for (let i = 0; i < 31; i++) {
        let powerOf2 = 1 << i;
        const powerOf2SortedDigits = getSortedDigits(powerOf2);
        if (nSortedDigits === powerOf2SortedDigits) {
            return true;
        }
    }
    return false;
};