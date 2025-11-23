function countGoodSubarrays(nums, k) {
    let count = 0;
    let left = 0;
    const freq = {};

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq[num] = (freq[num] || 0) + 1;

        while (freq[num] > k) {
            const leftNum = nums[left];
            freq[leftNum]--;
            left++;
        }

        count += right - left + 1;
    }

    return count;
}