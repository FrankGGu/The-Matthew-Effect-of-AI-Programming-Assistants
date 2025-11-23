var isTransformable = function(s, t) {
    const n = s.length;

    const sCounts = new Array(10).fill(0);
    const tCounts = new Array(10).fill(0);

    for (let i = 0; i < n; i++) {
        sCounts[parseInt(s[i])]++;
        tCounts[parseInt(t[i])]++;
    }

    for (let i = 0; i < 10; i++) {
        if (sCounts[i] !== tCounts[i]) {
            return false;
        }
    }

    const sIndices = Array(10).fill(0).map(() => []);

    for (let i = 0; i < n; i++) {
        sIndices[parseInt(s[i])].push(i);
    }

    for (let i = 0; i < n; i++) {
        const targetDigit = parseInt(t[i]);

        const originalSIdx = sIndices[targetDigit].shift();

        for (let d = 0; d < targetDigit; d++) {
            if (sIndices[d].length > 0 && sIndices[d][0] < originalSIdx) {
                return false;
            }
        }
    }

    return true;
};