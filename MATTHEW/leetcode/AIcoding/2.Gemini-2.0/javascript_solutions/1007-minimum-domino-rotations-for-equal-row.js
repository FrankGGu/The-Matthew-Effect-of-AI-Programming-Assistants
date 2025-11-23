var minDominoRotations = function(tops, bottoms) {
    const n = tops.length;

    const check = (target) => {
        let rotationsTop = 0;
        let rotationsBottom = 0;
        for (let i = 0; i < n; i++) {
            if (tops[i] !== target && bottoms[i] !== target) {
                return Infinity;
            } else if (tops[i] !== target) {
                rotationsTop++;
            } else if (bottoms[i] !== target) {
                rotationsBottom++;
            }
        }
        return Math.min(rotationsTop, rotationsBottom);
    };

    let result = Math.min(check(tops[0]), check(bottoms[0]));
    if (result === Infinity) return -1;
    return result;
};