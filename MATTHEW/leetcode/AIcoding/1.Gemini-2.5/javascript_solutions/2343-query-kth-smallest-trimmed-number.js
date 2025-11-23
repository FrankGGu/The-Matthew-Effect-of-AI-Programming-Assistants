var smallestTrimmedNumbers = function(nums, queries) {
    const n = nums.length;
    const numLength = nums[0].length;
    const results = [];

    for (let i = 0; i < queries.length; i++) {
        const k = queries[i][0];
        const trim = queries[i][1];

        const trimmedNumbersWithIndices = [];
        for (let j = 0; j < n; j++) {
            const trimmedNum = nums[j].substring(numLength - trim);
            trimmedNumbersWithIndices.push({ value: trimmedNum, originalIndex: j });
        }

        trimmedNumbersWithIndices.sort((a, b) => {
            if (a.value === b.value) {
                return a.originalIndex - b.originalIndex;
            }
            return a.value.localeCompare(b.value);
        });

        results.push(trimmedNumbersWithIndices[k - 1].originalIndex);
    }

    return results;
};