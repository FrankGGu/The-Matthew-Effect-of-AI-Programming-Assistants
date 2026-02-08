var getMaxRepetitions = function(s1, n1, s2, n2) {
    if (n1 === 0) return 0;

    const s1Len = s1.length;
    const s2Len = s2.length;

    let s2Idx = 0;
    let s2TotalCount = 0;

    const s2IdxHistory = new Array(s2Len).fill(null);

    let i = 0;
    while (i < n1) {
        const s2StartIdx = s2Idx;

        if (s2IdxHistory[s2StartIdx] !== null) {
            const [prevS1RepNum, prevS2TotalCount] = s2IdxHistory[s2StartIdx];

            const cycleS1Len = i - prevS1RepNum;
            const cycleS2Len = s2TotalCount - prevS2TotalCount;

            const remainingS1Reps = n1 - i;
            const numCycles = Math.floor(remainingS1Reps / cycleS1Len);

            s2TotalCount += numCycles * cycleS2Len;
            i += numCycles * cycleS1Len;

            if (i >= n1) break;
        } else {
            s2IdxHistory[s2StartIdx] = [i, s2TotalCount];
        }

        for (let k = 0; k < s1Len; k++) {
            if (s1[k] === s2[s2Idx]) {
                s2Idx++;
                if (s2Idx === s2Len) {
                    s2Idx = 0;
                    s2TotalCount++;
                }
            }
        }
        i++;
    }

    return Math.floor(s2TotalCount / n2);
};