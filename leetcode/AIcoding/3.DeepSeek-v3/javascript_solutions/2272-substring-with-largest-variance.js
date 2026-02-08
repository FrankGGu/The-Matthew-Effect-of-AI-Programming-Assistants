var largestVariance = function(s) {
    const uniqueChars = [...new Set(s)];
    let maxVariance = 0;

    for (let i = 0; i < uniqueChars.length; i++) {
        for (let j = 0; j < uniqueChars.length; j++) {
            if (i === j) continue;
            const a = uniqueChars[i];
            const b = uniqueChars[j];
            let variance = 0;
            let hasB = false;
            let firstB = false;

            for (const char of s) {
                if (char === a) {
                    variance++;
                } else if (char === b) {
                    hasB = true;
                    if (firstB && variance >= 0) {
                        firstB = false;
                    } else if (--variance < 0) {
                        firstB = true;
                        variance = -1;
                    }
                }
                if (hasB) {
                    maxVariance = Math.max(maxVariance, variance);
                }
            }
        }
    }

    return maxVariance;
};