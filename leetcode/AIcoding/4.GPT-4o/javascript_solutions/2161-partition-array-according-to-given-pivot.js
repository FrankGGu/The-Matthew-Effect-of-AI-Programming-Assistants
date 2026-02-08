function pivotArray(nums, pivot) {
    const left = [];
    const right = [];
    const equal = [];

    for (const num of nums) {
        if (num < pivot) {
            left.push(num);
        } else if (num > pivot) {
            right.push(num);
        } else {
            equal.push(num);
        }
    }

    return [...left, ...equal, ...right];
}