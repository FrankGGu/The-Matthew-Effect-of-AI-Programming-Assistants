function zeroArray(nums) {
    const result = [];
    const numCount = {};

    for (const num of nums) {
        numCount[num] = (numCount[num] || 0) + 1;
    }

    for (const [num, count] of Object.entries(numCount)) {
        if (count % 2 !== 0) return false;
    }

    for (const num of nums) {
        if (num !== 0) {
            result.push(num);
        }
    }

    return result.length === 0 || zeroArray(result);
}