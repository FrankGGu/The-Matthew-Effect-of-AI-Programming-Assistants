var minOperations = function(nums, target) {
    let sum = 0;
    nums.sort((a, b) => a - b);

    for (let num of nums) {
        sum += num;
    }

    if (sum < target) return -1;

    let ops = 0;
    let currSum = 0;
    let i = nums.length - 1;

    while (currSum < target) {
        if (i >= 0 && nums[i] <= target - currSum) {
            currSum += nums[i];
            i--;
        } else {
            if (target - currSum === 0) break;
            let j = 0;
            while (nums[j] !== (nums[0] << ops)) {
                j++;
            }

            nums.splice(j, 1);
            nums.push(nums[0] << ops >> 1);
            nums.push(nums[0] << ops >> 1);
            ops++;
            nums.sort((a, b) => a - b);
            i = nums.length - 1;
        }
    }

    return ops;
};