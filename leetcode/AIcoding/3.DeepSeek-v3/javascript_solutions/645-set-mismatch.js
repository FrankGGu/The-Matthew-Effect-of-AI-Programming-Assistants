var findErrorNums = function(nums) {
    let n = nums.length;
    let duplicate = -1;
    let missing = -1;

    for (let i = 0; i < n; i++) {
        let num = Math.abs(nums[i]);
        if (nums[num - 1] < 0) {
            duplicate = num;
        } else {
            nums[num - 1] *= -1;
        }
    }

    for (let i = 0; i < n; i++) {
        if (nums[i] > 0) {
            missing = i + 1;
            break;
        }
    }

    return [duplicate, missing];
};