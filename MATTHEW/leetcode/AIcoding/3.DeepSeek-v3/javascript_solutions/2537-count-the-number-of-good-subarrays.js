var countGood = function(nums, k) {
    let count = 0;
    let left = 0;
    const freq = {};
    let pairs = 0;

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        pairs += freq[num] || 0;
        freq[num] = (freq[num] || 0) + 1;

        while (pairs >= k) {
            const leftNum = nums[left];
            freq[leftNum] -= 1;
            pairs -= freq[leftNum];
            left++;
            count += nums.length - right;
        }
    }

    return count;
};