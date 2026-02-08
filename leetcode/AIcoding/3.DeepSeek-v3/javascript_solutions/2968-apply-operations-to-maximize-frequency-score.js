var maxFrequencyScore = function(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    let left = 0;
    let maxScore = 0;

    for (let right = 0; right < n; right++) {
        while (left <= right) {
            const m = left + Math.floor((right - left) / 2);
            const sumLeft = nums[m] * (m - left + 1) - (prefix[m + 1] - prefix[left]);
            const sumRight = (prefix[right + 1] - prefix[m + 1]) - nums[m] * (right - m);
            const total = sumLeft + sumRight;
            if (total <= k) {
                break;
            } else {
                left++;
            }
        }
        maxScore = Math.max(maxScore, right - left + 1);
    }

    return maxScore;
};