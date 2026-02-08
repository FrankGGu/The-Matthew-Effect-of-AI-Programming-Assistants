var recoverArray = function(n, sums) {
    sums.sort((a, b) => a - b);

    const result = [];

    // Helper function to extract the next set of sums and check if 0 is present
    // This function assumes `val` is the element being removed.
    // It returns `[next_sums, contains_zero]`.
    const getNextSums = (currentSums, val) => {
        const freq = new Map();
        for (const s of currentSums) {
            freq.set(s, (freq.get(s) || 0) + 1);
        }

        const nextSums = [];
        let containsZero = false;

        for (const s of currentSums) {
            if (freq.get(s) > 0) {
                freq.set(s, freq.get(s) - 1);

                let sumToAdd;
                let pairedSum;

                if (val > 0) {
                    // If val is positive, 's' is from S_0, 's + val' is from S_x
                    pairedSum = s + val;
                    sumToAdd = s;
                } else { // val < 0
                    // If val is negative, 's' is from S_x, 's - val' is from S_0
                    pairedSum = s - val;
                    sumToAdd = s - val;
                }

                freq.set(pairedSum, freq.get(pairedSum) - 1);
                nextSums.push(sumToAdd);

                if (sumToAdd === 0) {
                    containsZero = true;
                }
            }
        }
        return [nextSums, containsZero];
    };

    for (let i = 0; i < n; i++) {
        // The smallest non-zero difference between sums[0] and sums[1] is a candidate for an element 'x'
        const diff = sums[1] - sums[0];

        // Try 'x' as positive diff
        const [nextSumsPos, hasZeroPos] = getNextSums(sums, diff);

        if (hasZeroPos) {
            result.push(diff);
            sums = nextSumsPos;
        } else {
            // If 0 is not found when considering 'diff' as positive,
            // it means the actual element is '-diff'.
            // The problem guarantees one of the choices will lead to a valid array.
            result.push(-diff);
            // Recalculate next sums with '-diff'
            const [nextSumsNeg, _] = getNextSums(sums, -diff);
            sums = nextSumsNeg;
        }
    }

    return result;
};