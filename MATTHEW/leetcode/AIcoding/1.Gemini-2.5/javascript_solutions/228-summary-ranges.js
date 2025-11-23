var summaryRanges = function(nums) {
    const result = [];
    if (nums.length === 0) {
        return result;
    }

    let i = 0;
    while (i < nums.length) {
        const start = nums[i];
        let j = i;
        while (j + 1 < nums.length && nums[j] + 1 === nums[j + 1]) {
            j++;
        }
        const end = nums[j];

        if (start === end) {
            result.push(start.toString());
        } else {
            result.push(`${start}->${end}`);
        }
        i = j + 1;
    }

    return result;
};