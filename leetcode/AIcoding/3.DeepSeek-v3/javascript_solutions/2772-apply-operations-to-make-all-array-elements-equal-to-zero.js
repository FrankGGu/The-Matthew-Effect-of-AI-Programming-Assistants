var checkArray = function(nums, k) {
    const n = nums.length;
    let diff = new Array(n + 1).fill(0);
    let current = 0;

    for (let i = 0; i < n; i++) {
        current += diff[i];
        nums[i] += current;

        if (nums[i] === 0) continue;
        if (nums[i] < 0 || i + k > n) return false;

        const subtract = nums[i];
        current -= subtract;
        diff[i + k] += subtract;
        nums[i] = 0;
    }

    return true;
};