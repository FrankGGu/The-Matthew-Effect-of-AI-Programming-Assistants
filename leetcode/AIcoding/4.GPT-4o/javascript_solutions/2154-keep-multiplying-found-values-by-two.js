function findFinalValue(nums, original) {
    const numSet = new Set(nums);
    while (numSet.has(original)) {
        original *= 2;
    }
    return original;
}