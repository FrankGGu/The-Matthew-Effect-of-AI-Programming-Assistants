var countSubarrays = function(nums, k) {
    const n = nums.length;
    let maxNum = Math.max(...nums);
    let maxIndices = [];
    for (let i = 0; i < n; i++) {
        if (nums[i] === maxNum) {
            maxIndices.push(i);
        }
    }
    if (maxIndices.length < k) {
        return 0;
    }
    let res = 0;
    for (let i = 0; i <= maxIndices.length - k; i++) {
        let left = i === 0 ? -1 : maxIndices[i - 1];
        let right = i + k - 1 === maxIndices.length - 1 ? n : maxIndices[i + k];
        let l = maxIndices[i] - left;
        let r = right - maxIndices[i + k - 1];
        res += l * r;
    }
    return res;
};