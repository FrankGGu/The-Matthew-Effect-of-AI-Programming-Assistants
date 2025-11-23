var countSmaller = function(nums) {
    const n = nums.length;
    const counts = new Array(n).fill(0);
    const sorted = [];

    for (let i = n - 1; i >= 0; i--) {
        let left = 0;
        let right = sorted.length;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] >= nums[i]) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        counts[i] = left;
        sorted.splice(left, 0, nums[i]);
    }

    return counts;
};