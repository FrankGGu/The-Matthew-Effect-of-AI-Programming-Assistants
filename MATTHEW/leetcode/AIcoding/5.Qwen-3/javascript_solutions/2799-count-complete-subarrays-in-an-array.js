function countCompleteSubarrays(nums) {
    const unique = new Set(nums).size;
    let count = 0;
    let left = 0;
    const freq = {};

    for (let right = 0; right < nums.length; right++) {
        freq[nums[right]] = (freq[nums[right]] || 0) + 1;

        while (Object.keys(freq).length === unique) {
            count++;
            freq[nums[left]]--;
            if (freq[nums[left]] === 0) {
                delete freq[nums[left]];
            }
            left++;
        }
    }

    return count;
}