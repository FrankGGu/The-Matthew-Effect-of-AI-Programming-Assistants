var largestVariance = function(s) {
    let ans = 0;
    const chars = new Set(s);

    for (const a of chars) {
        for (const b of chars) {
            if (a === b) continue;

            let aCount = 0;
            let bCount = 0;
            let aRemaining = 0;
            let bRemaining = 0;

            for (const char of s) {
                if (char === a) {
                    aCount++;
                } else if (char === b) {
                    bCount++;
                }

                if (bCount > 0) {
                    ans = Math.max(ans, aCount - bCount);
                }

                if (aCount > bCount && aRemaining > 0) {
                    aCount = 0;
                    bCount = 0;
                }

                if (bCount > aCount) {
                   aCount = 0;
                   bCount = 0;
                }
            }

           aCount = 0;
           bCount = 0;

           for (let i = s.length - 1; i >= 0; i--) {
                if (s[i] === a) {
                    aCount++;
                } else if (s[i] === b) {
                    bCount++;
                }

                if (bCount > 0) {
                    ans = Math.max(ans, aCount - bCount);
                }

                if (aCount > bCount) {
                   aCount = 0;
                   bCount = 0;
                }

                if (bCount > aCount && aRemaining > 0) {
                    aCount = 0;
                    bCount = 0;
                }
            }

        }
    }

    return ans;
};