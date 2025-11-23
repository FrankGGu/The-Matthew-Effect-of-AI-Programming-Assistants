function subarraysWithKDifferentIntegers(nums, k) {
    function atMostK(k) {
        let count = 0;
        let left = 0;
        const freq = {};
        for (let right = 0; right < nums.length; right++) {
            freq[nums[right]] = (freq[nums[right]] || 0) + 1;
            while (Object.keys(freq).length > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] === 0) {
                    delete freq[nums[left]];
                }
                left++;
            }
            count += right - left + 1;
        }
        return count;
    }
    return atMostK(k) - atMostK(k - 1);
}