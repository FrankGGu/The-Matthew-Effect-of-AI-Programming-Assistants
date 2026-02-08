function divideArray(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    for (const freq of Object.values(count)) {
        if (freq % 2 !== 0) return false;
    }
    return true;
}