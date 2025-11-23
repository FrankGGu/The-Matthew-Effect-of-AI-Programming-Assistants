var shortestWay = function(s, t) {
    const tChars = new Set();
    for (const char of t) {
        tChars.add(char);
    }

    for (const char of s) {
        if (!tChars.has(char)) {
            return -1;
        }
    }

    let count = 0;
    let sIdx = 0;

    while (sIdx < s.length) {
        count++;
        let tIdx = 0;
        let prevSIdx = sIdx;

        while (tIdx < t.length && sIdx < s.length) {
            if (t[tIdx] === s[sIdx]) {
                sIdx++;
            }
            tIdx++;
        }

        if (sIdx === prevSIdx) {
            return -1;
        }
    }

    return count;
};