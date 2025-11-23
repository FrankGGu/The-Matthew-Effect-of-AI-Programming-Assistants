function minOperations(nums) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let operations = 0;
    for (const count of freq.values()) {
        operations += Math.ceil(count / 2);
    }

    return operations + (nums.length % 2);
}