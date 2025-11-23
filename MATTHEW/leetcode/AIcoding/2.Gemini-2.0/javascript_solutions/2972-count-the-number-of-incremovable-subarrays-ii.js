var countSubarrays = function(nums) {
    let n = nums.length;
    let count = 0;

    for (let i = 0; i < (1 << n); i++) {
        let subarray = [];
        for (let j = 0; j < n; j++) {
            if ((i & (1 << j)) === 0) {
                subarray.push(nums[j]);
            }
        }

        if (subarray.length === 0) {
            count++;
            continue;
        }

        let sorted = true;
        for (let k = 1; k < subarray.length; k++) {
            if (subarray[k] <= subarray[k - 1]) {
                sorted = false;
                break;
            }
        }

        if (sorted) {
            count++;
        }
    }

    return count;
};