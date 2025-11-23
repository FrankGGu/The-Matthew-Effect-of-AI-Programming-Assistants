var minDeletion = function(nums) {
    let deletions = 0;
    let n = nums.length;
    for (let i = 0; i < n; ) {
        if (i % 2 === 0 && i + 1 < n && nums[i] === nums[i + 1]) {
            deletions++;
            n--;
            for (let j = i + 1; j < n; j++) {
                nums[j] = nums[j + 1];
            }
        } else {
            i++;
        }
    }
    if ((n) % 2 !== 0) {
        deletions++;
    }
    return deletions;
};