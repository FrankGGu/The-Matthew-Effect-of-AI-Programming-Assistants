var countHillValley = function(nums) {
    let count = 0;
    let n = nums.length;
    if (n < 3) {
        return 0;
    }

    for (let i = 1; i < n - 1; i++) {
        if (nums[i] === nums[i - 1]) {
            continue;
        }

        let left = nums[i - 1];
        let right = -1;

        for (let j = i + 1; j < n; j++) {
            if (nums[j] !== nums[i]) {
                right = nums[j];
                break;
            }
        }

        if (right === -1) {
            continue;
        }

        if ((nums[i] > left && nums[i] > right) || (nums[i] < left && nums[i] < right)) {
            count++;
        }
    }

    return count;
};