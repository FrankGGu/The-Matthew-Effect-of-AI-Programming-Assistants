var powerfulIntegers = function(x, y, bound) {
    const set = new Set();
    for (let a = 1; a <= bound; x === 1 ? a = bound + 1 : a *= x) {
        for (let b = 1; a + b <= bound; y === 1 ? b = bound + 1 : b *= y) {
            set.add(a + b);
        }
    }
    return Array.from(set);
};