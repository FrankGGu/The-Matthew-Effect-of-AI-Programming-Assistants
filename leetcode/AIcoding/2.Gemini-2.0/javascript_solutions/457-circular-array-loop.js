var circularArrayLoop = function(nums) {
    const n = nums.length;

    function getNext(i) {
        return ((i + nums[i]) % n + n) % n;
    }

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) continue;

        let slow = i, fast = i;
        let sign = nums[i] > 0;

        while (true) {
            slow = getNext(slow);
            if (nums[slow] > 0 !== sign) break;

            fast = getNext(fast);
            if (nums[fast] > 0 !== sign) break;
            fast = getNext(fast);
            if (nums[fast] > 0 !== sign) break;

            if (slow === fast) {
                if (slow === getNext(slow)) break;
                return true;
            }
        }

        slow = i;
        let val = nums[i];
        while (nums[slow] * val > 0) {
            let next = getNext(slow);
            nums[slow] = 0;
            slow = next;
        }
    }

    return false;
};