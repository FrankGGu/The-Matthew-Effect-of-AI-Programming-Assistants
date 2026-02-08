var minDeletion = function(nums) {
    let count = 0;
    let i = 0;
    while (i < nums.length - count) {
        if ((i % 2 === 0) && (i + 1 < nums.length - count) && (nums[i] === nums[i + 1])) {
            count++;
            nums.splice(i, 1);
        } else {
            i++;
        }
    }

    if ((nums.length - count) % 2 !== 0) {
        count++;
    }

    return count;
};