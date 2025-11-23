var makeLexicographicallySmallestArray = function(nums, limit) {
    const n = nums.length;
    if (n === 0) {
        return [];
    }

    const indexedNums = new Array(n);
    for (let i = 0; i < n; i++) {
        indexedNums[i] = [nums[i], i];
    }

    indexedNums.sort((a, b) => a[0] - b[0]);

    const result = new Array(n);

    let currentGroupValues = [];
    let currentGroupIndices = [];

    for (let i = 0; i < n; i++) {
        const [val, originalIdx] = indexedNums[i];

        if (currentGroupValues.length === 0 || val - currentGroupValues[currentGroupValues.length - 1] <= limit) {
            currentGroupValues.push(val);
            currentGroupIndices.push(originalIdx);
        } else {
            currentGroupIndices.sort((a, b) => a - b);

            for (let j = 0; j < currentGroupValues.length; j++) {
                result[currentGroupIndices[j]] = currentGroupValues[j];
            }

            currentGroupValues = [val];
            currentGroupIndices = [originalIdx];
        }
    }

    if (currentGroupValues.length > 0) {
        currentGroupIndices.sort((a, b) => a - b);
        for (let j = 0; j < currentGroupValues.length; j++) {
            result[currentGroupIndices[j]] = currentGroupValues[j];
        }
    }

    return result;
};