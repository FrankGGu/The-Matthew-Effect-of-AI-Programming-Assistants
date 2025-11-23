var checkArray = function(nums, k) {
    let n = nums.length;
    let diff = new Array(n).fill(0);
    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += diff[i];
        if (nums[i] < sum) {
            return false;
        }
        let decrease = nums[i] - sum;
        if (i + k > n) {
            return false;
        }
        sum += decrease;
        if (i + k < n) {
            diff[i + k] -= decrease;
        }
    }
    return true;
};