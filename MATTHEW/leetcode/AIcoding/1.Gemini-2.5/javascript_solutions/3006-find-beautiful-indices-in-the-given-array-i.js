var beautifulIndices = function(s, a, b, k) {
    const findAllOccurrences = (text, pattern) => {
        const indices = [];
        let idx = text.indexOf(pattern, 0);
        while (idx !== -1) {
            indices.push(idx);
            idx = text.indexOf(pattern, idx + 1);
        }
        return indices;
    };

    const indicesA = findAllOccurrences(s, a);
    const indicesB = findAllOccurrences(s, b);
    const result = new Set();

    for (const idxA of indicesA) {
        for (const idxB of indicesB) {
            if (Math.abs(idxA - idxB) <= k) {
                result.add(idxA);
                break;
            }
        }
    }

    return Array.from(result).sort((x, y) => x - y);
};