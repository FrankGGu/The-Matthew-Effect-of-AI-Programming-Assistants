function finalArray(nums, operations) {
    let n = nums.length;
    let current = nums.slice();

    for (let op of operations) {
        for (let i = 0; i < n; i++) {
            current[i] *= op;
        }
    }

    return current;
}