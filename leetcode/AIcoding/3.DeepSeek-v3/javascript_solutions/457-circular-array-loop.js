var circularArrayLoop = function(nums) {
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) continue;
        let slow = i, fast = i;
        while (true) {
            slow = getNextIndex(nums, slow);
            fast = getNextIndex(nums, fast);
            if (nums[fast] * nums[i] <= 0) break;
            fast = getNextIndex(nums, fast);
            if (nums[fast] * nums[i] <= 0) break;
            if (slow === fast) {
                if (slow === getNextIndex(nums, slow)) break;
                return true;
            }
        }
        slow = i;
        while (nums[slow] * nums[i] > 0) {
            const next = getNextIndex(nums, slow);
            nums[slow] = 0;
            slow = next;
        }
    }
    return false;
};

function getNextIndex(nums, index) {
    const n = nums.length;
    const nextIndex = (index + nums[index]) % n;
    return nextIndex >= 0 ? nextIndex : nextIndex + n;
}