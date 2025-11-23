var powerfulIntegers = function(x, y, bound) {
    const result = new Set();
    for (let i = 0; Math.pow(x, i) < bound; i++) {
        for (let j = 0; Math.pow(y, j) < bound; j++) {
            const powerInt = Math.pow(x, i) + Math.pow(y, j);
            if (powerInt <= bound) {
                result.add(powerInt);
            } else {
                break;
            }
            if (y === 1) break;
        }
        if (x === 1) break;
    }
    return Array.from(result);
};