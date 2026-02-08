var minimumMoves = function(nums) {
    let n = nums.length;
    let lastDirtyIndex = -1;

    for (let i = n - 1; i >= 0; i--) {
        if (nums[i] === 0) {
            lastDirtyIndex = i;
            break;
        }
    }

    if (lastDirtyIndex === -1) {
        return 0;
    }

    let dirtyCount = 0;
    for (let i = 0; i <= lastDirtyIndex; i++) {
        if (nums[i] === 0) {
            dirtyCount++;
        }
    }

    return lastDirtyIndex + dirtyCount;
};