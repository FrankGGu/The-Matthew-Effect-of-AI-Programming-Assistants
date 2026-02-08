var countMatchingSubarrays = function(nums, pattern) {
    let count = 0;
    const n = nums.length;
    const m = pattern.length;

    for (let i = 0; i <= n - m - 1; i++) {
        let match = true;
        for (let j = 0; j < m; j++) {
            const num1 = nums[i + j];
            const num2 = nums[i + j + 1];
            let condition;
            if (pattern[j] === 1) {
                condition = num1 < num2;
            } else if (pattern[j] === 0) {
                condition = num1 === num2;
            } else {
                condition = num1 > num2;
            }
            if (!condition) {
                match = false;
                break;
            }
        }
        if (match) {
            count++;
        }
    }

    return count;
};