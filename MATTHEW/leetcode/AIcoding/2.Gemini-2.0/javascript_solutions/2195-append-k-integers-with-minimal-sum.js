var minimalKSum = function(nums, k) {
    nums.sort((a, b) => a - b);
    let sum = 0;
    let last = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > last) {
            let count = Math.min(k, nums[i] - last - 1);
            sum += (last + 1 + last + count) * count / 2;
            k -= count;
            last = nums[i];
            if (k === 0) break;
        }
    }
    if (k > 0) {
        sum += (last + 1 + last + k) * k / 2;
    }
    return sum;
};