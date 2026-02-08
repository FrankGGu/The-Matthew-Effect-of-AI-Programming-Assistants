var expressiveWords = function(S, words) {
    const count = (s) => {
        let counts = [];
        let prevChar = s[0];
        let count = 1;
        for (let i = 1; i < s.length; i++) {
            if (s[i] === prevChar) {
                count++;
            } else {
                counts.push([prevChar, count]);
                prevChar = s[i];
                count = 1;
            }
        }
        counts.push([prevChar, count]);
        return counts;
    };

    const canStretch = (sCount, wCount) => {
        if (sCount.length !== wCount.length) return false;
        for (let i = 0; i < sCount.length; i++) {
            const [sChar, sC] = sCount[i];
            const [wChar, wC] = wCount[i];
            if (sChar !== wChar) return false;
            if (sC < wC || (sC < 3 && sC !== wC)) return false;
        }
        return true;
    };

    const sCount = count(S);
    let expressiveCount = 0;
    for (let word of words) {
        const wCount = count(word);
        if (canStretch(sCount, wCount)) expressiveCount++;
    }
    return expressiveCount;
};