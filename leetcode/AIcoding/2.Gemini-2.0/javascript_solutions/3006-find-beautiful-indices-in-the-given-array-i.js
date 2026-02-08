var beautifulIndices = function(s, a, b) {
    const indicesA = [];
    const indicesB = [];
    const n = s.length;
    const lenA = a.length;
    const lenB = b.length;

    for (let i = 0; i <= n - lenA; i++) {
        if (s.substring(i, i + lenA) === a) {
            indicesA.push(i);
        }
    }

    for (let i = 0; i <= n - lenB; i++) {
        if (s.substring(i, i + lenB) === b) {
            indicesB.push(i);
        }
    }

    const result = [];
    for (const i of indicesA) {
        let found = false;
        for (const j of indicesB) {
            if (Math.abs(i - j) <= Math.min(a.length,b.length)) {
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