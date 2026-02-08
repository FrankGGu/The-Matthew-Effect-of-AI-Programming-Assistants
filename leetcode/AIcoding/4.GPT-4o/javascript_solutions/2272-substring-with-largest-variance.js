var largestVariance = function(s) {
    let maxVar = 0;
    const uniqueChars = [...new Set(s)];

    for (let i = 0; i < uniqueChars.length; i++) {
        for (let j = 0; j < uniqueChars.length; j++) {
            if (i !== j) {
                let countA = 0, countB = 0;
                for (const char of s) {
                    if (char === uniqueChars[i]) countA++;
                    if (char === uniqueChars[j]) countB++;
                    if (countA > 0 && countB > 0) {
                        maxVar = Math.max(maxVar, countA - countB);
                    }
                    if (countB > countA) {
                        countA = 0;
                        countB = 0;
                    }
                }
            }
        }
    }

    return maxVar;
};