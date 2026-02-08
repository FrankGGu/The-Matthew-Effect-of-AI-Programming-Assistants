var incremovableSubarrayCount = function(nums) {
    let n = nums.length;
    let count = 0;
    for (let i = 0; i < (1 << n); i++) {
        let subarray = [];
        for (let j = 0; j < n; j++) {
            if ((i & (1 << j)) == 0) {
                subarray.push(nums[j]);
            }
        }
        if (subarray.length === 0 || isIncreasing(subarray)) {
            count++;
        }
    }
    return count;

    function isIncreasing(arr) {
        for (let i = 1; i < arr.length; i++) {
            if (arr[i] <= arr[i - 1]) {
                return false;
            }
        }
        return true;
    }
};