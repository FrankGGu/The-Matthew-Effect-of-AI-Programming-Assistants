function canDivideIntoSets(nums, k) {
    if (nums.length % k !== 0) return false;

    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const uniqueNums = Object.keys(count).map(Number).sort((a, b) => a - b);

    for (const num of uniqueNums) {
        while (count[num] > 0) {
            for (let i = 0; i < k; i++) {
                if (count[num + i] === undefined || count[num + i] === 0) {
                    return false;
                }
                count[num + i]--;
            }
        }
    }

    return true;
}