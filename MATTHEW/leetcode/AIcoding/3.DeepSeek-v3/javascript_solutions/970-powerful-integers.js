var powerfulIntegers = function(x, y, bound) {
    const result = new Set();
    let a = 1;

    for (let i = 0; a <= bound; i++) {
        let b = 1;
        for (let j = 0; a + b <= bound; j++) {
            result.add(a + b);
            if (y === 1) break;
            b *= y;
        }
        if (x === 1) break;
        a *= x;
    }

    return Array.from(result).sort((a, b) => a - b);
};