var circularArrayLoop = function(nums) {
    const n = nums.length;

    const nextIndex = (i) => (i + nums[i] + n) % n;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) continue;

        let slow = i, fast = i;
        const isForward = nums[i] > 0;

        while (true) {
            slow = nextIndex(slow);
            fast = nextIndex(nextIndex(fast));

            if (nums[slow] * (isForward ? 1 : -1) <= 0 || nums[fast] * (isForward ? 1 : -1) <= 0) break;
            if (slow === fast) {
                if (slow === nextIndex(slow)) break;
                return true;
            }
        }

        let j = i;
        while (nums[j] * (isForward ? 1 : -1) > 0) {
            const temp = j;
            j = nextIndex(j);
            nums[temp] = 0;
        }
    }

    return false;
};