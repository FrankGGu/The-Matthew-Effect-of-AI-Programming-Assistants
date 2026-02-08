var findDifferentBinaryString = function(nums) {
    const n = nums.length;
    let result = [];

    for (let i = 0; i < n; i++) {
        if (nums[i][i] === '0') {
            result.push('1');
        } else {
            result.push('0');
        }
    }

    return result.join('');
};