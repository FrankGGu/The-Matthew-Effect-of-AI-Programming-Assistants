function minimumOperations(nums, k) {
    const numSet = new Set(nums);
    let operations = 0;

    for (let i = 0; i < 32; i++) {
        const bit = 1 << i;
        if ((k & bit) !== 0 && !numSet.has(bit)) {
            operations++;
        }
    }

    return operations;
}