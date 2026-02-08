var maximumDistinctElements = function(nums, k) {
    const frequencyMap = new Map();
    for (const num of nums) {
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
    }

    const duplicates = [];
    let distinctCount = 0;

    for (const [num, freq] of frequencyMap) {
        if (freq === 1) {
            distinctCount++;
        } else {
            duplicates.push(freq - 1);
        }
    }

    duplicates.sort((a, b) => a - b);

    for (const dup of duplicates) {
        if (k >= dup) {
            k -= dup;
            distinctCount++;
        } else {
            break;
        }
    }

    if (k > 0) {
        distinctCount -= k;
    }

    return Math.max(distinctCount, 0);
};