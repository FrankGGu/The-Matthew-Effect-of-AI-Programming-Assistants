var rotate = function(nums, k) {
    const n = nums.length;
    k = k % n;

    if (k === 0) {
        return;
    }

    const rotatedPart = nums.splice(n - k);
    nums.unshift(...rotatedPart);
};