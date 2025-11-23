function powerfulIntegers(x, y, bound) {
    const result = new Set();
    for (let i = 0; Math.pow(x, i) <= bound; i++) {
        for (let j = 0; Math.pow(y, j) <= bound; j++) {
            const sum = Math.pow(x, i) + Math.pow(y, j);
            if (sum <= bound) {
                result.add(sum);
            }
        }
    }
    return Array.from(result);
}