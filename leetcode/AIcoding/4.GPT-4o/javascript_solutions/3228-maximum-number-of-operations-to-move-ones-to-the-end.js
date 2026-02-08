function maxOperations(nums) {
    let count = 0;
    for (let num of nums) {
        if (num === 1) count++;
    }
    return count === 0 ? 0 : nums.length - count;
}