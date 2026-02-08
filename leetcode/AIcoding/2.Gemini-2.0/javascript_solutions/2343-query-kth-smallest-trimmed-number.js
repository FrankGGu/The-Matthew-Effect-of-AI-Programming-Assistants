var smallestTrimmedNumbers = function(nums, queries) {
    const result = [];

    for (const query of queries) {
        const k = query[0];
        const trim = query[1];

        const trimmedNums = nums.map((num, index) => {
            const trimmed = num.slice(num.length - trim);
            return {
                trimmed,
                index
            };
        });

        trimmedNums.sort((a, b) => {
            if (a.trimmed === b.trimmed) {
                return a.index - b.index;
            }
            return a.trimmed.localeCompare(b.trimmed);
        });

        result.push(nums.indexOf(nums[trimmedNums[k - 1].index]));
    }

    return result;
};