var largestVariance = function(s) {
    let maxOverallVariance = 0;

    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < 26; j++) {
            if (i === j) {
                continue;
            }

            const char1 = String.fromCharCode('a'.charCodeAt(0) + i);
            const char2 = String.fromCharCode('a'.charCodeAt(0) + j);

            let count1 = 0;
            let count2 = 0;
            let foundChar2BeforeReset = false; 

            for (let k = 0; k < s.length; k++) {
                const char = s[k];

                if (char === char1) {
                    count1++;
                } else if (char === char2) {
                    count2++;
                }

                if (count2 > 0) {
                    maxOverallVariance = Math.max(maxOverallVariance, count1 - count2);
                }

                if (foundChar2BeforeReset) {
                    maxOverallVariance = Math.max(maxOverallVariance, count1 - 1);
                }

                if (count1 < count2) {
                    count1 = 0;
                    count2 = 0;
                    foundChar2BeforeReset = true;
                }
            }
        }
    }

    return maxOverallVariance;
};