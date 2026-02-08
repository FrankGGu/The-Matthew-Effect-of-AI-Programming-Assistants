var countHillValley = function(nums) {
    let count = 0;
    let prev = nums[0];
    const filtered = [prev];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] !== prev) {
            filtered.push(nums[i]);
            prev = nums[i];
        }
    }

    for (let i = 1; i < filtered.length - 1; i++) {
        const left = filtered[i - 1];
        const mid = filtered[i];
        const right = filtered[i + 1];

        if ((mid > left && mid > right) || (mid < left && mid < right)) {
            count++;
        }
    }

    return count;
};