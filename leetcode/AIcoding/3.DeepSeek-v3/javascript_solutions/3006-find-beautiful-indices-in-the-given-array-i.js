var beautifulIndices = function(s, a, b, k) {
    const findIndices = (str, pattern) => {
        const indices = [];
        const len = pattern.length;
        for (let i = 0; i <= str.length - len; i++) {
            if (str.substring(i, i + len) === pattern) {
                indices.push(i);
            }
        }
        return indices;
    };

    const aIndices = findIndices(s, a);
    const bIndices = findIndices(s, b);
    const result = [];

    for (const i of aIndices) {
        let found = false;
        for (const j of bIndices) {
            if (Math.abs(i - j) <= k) {
                found = true;
                break;
            }
        }
        if (found) {
            result.push(i);
        }
    }

    return result.sort((x, y) => x - y);
};