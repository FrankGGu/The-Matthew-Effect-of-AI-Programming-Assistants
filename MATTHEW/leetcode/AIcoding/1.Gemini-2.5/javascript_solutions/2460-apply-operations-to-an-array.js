var applyOperations = function(nums) {
    const n = nums.length;

    for (let i = 0; i < n - 1; i++) {
        if (nums[i] === nums[i + 1]) {
            nums[i] *= 2;
            nums[i + 1] = 0;
        }
    }

    let writePointer = 0;
    for (let readPointer = 0; readPointer < n; readPointer++) {
        if (nums[readPointer] !== 0) {
            nums[writePointer] = nums[readPointer];
            writePointer++;
        }
    }

    for (let i = writePointer; i < n; i++) {
        nums[i] = 0;
    }

    return nums;
};