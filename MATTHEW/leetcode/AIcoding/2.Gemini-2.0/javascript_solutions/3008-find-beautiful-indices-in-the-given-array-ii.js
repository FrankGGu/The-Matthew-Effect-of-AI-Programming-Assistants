var beautifulIndices = function(s, a, b, k) {
    const n = s.length;
    const m1 = a.length;
    const m2 = b.length;
    const indicesA = [];
    const indicesB = [];

    for (let i = 0; i <= n - m1; i++) {
        if (s.substring(i, i + m1) === a) {
            indicesA.push(i);
        }
    }

    for (let i = 0; i <= n - m2; i++) {
        if (s.substring(i, i + m2) === b) {
            indicesB.push(i);
        }
    }

    const result = [];
    for (const i of indicesA) {
        let found = false;
        for (const j of indicesB) {
            if (Math.abs(i - j) <= k) {
                found = true;
                break;
            }
        }
        if (found) {
            result.push(i);
        }
    }

    return result;
};