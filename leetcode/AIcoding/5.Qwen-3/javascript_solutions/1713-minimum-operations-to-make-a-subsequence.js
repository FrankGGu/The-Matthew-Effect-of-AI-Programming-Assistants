function minOperations(nums, target) {
    let operations = 0;
    let i = 0;
    let j = 0;

    while (i < nums.length && j < target.length) {
        if (nums[i] === target[j]) {
            i++;
            j++;
        } else {
            operations++;
            i++;
        }
    }

    return operations + (target.length - j);
}