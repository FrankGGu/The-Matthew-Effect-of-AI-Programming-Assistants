var findNumberOfLIS = function(nums) {
    const n = nums.length;
    if (n === 0) return 0;

    const lengths = new Array(n).fill(1);
    const counts = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                if (lengths[j] + 1 > lengths[i]) {
                    lengths[i] = lengths[j] + 1;
                    counts[i] = counts[j];
                } else if (lengths[j] + 1 === lengths[i]) {
                    counts[i] += counts[j];
                }
            }
        }
    }

    const maxLen = Math.max(...lengths);
    let result = 0;

    for (let i = 0; i < n; i++) {
        if (lengths[i] === maxLen) {
            result += counts[i];
        }
    }

    return result;
};