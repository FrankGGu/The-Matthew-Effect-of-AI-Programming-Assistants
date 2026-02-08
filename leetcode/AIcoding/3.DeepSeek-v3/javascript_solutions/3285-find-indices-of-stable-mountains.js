var findStableMountainIndices = function(nums) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const result = [];

    for (let i = 1; i < n; i++) {
        if (nums[i] > nums[i - 1]) {
            left[i] = left[i - 1] + 1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] > nums[i + 1]) {
            right[i] = right[i + 1] + 1;
        }
    }

    for (let i = 0; i < n; i++) {
        if (left[i] >= 2 && right[i] >= 2) {
            result.push(i);
        }
    }

    return result;
};