var getMaxRepetitions = function(s1, n1, s2, n2) {
    if (!s1 || !s2 || n1 <= 0 || n2 <= 0) return 0;

    const s1Len = s1.length;
    const s2Len = s2.length;

    let repeatCount = 0;
    let s1Index = 0;
    let s2Index = 0;

    const seen = new Map();
    seen.set(0, [0, 0]);

    for (let i = 1; i <= n1; i++) {
        for (let j = 0; j < s1Len; j++) {
            if (s1[j] === s2[s2Index]) {
                s2Index++;
                if (s2Index === s2Len) {
                    repeatCount++;
                    s2Index = 0;
                }
            }
        }

        if (seen.has(s2Index)) {
            const [prevI, prevRepeatCount] = seen.get(s2Index);
            const patternLength = i - prevI;
            const patternRepeatCount = repeatCount - prevRepeatCount;

            const remainingRepeats = Math.floor((n1 - i) / patternLength);
            repeatCount += remainingRepeats * patternRepeatCount;
            i += remainingRepeats * patternLength;
        } else {
            seen.set(s2Index, [i, repeatCount]);
        }
    }

    return Math.floor(repeatCount / n2);
};