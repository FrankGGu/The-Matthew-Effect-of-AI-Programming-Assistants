function medianOfUniquenessArray(nums) {
    const n = nums.length;
    const totalSubarrays = n * (n + 1) / 2;
    let left = 1, right = n;
    let result = n;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (countSubarraysWithAtMostKDistinct(nums, mid) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}

function countSubarraysWithAtMostKDistinct(nums, k) {
    const n = nums.length;
    const freq = {};
    let left = 0, distinct = 0, count = 0;
    const totalSubarrays = n * (n + 1) / 2;
    let required = Math.ceil(totalSubarrays / 2);

    for (let right = 0; right < n; right++) {
        if (!freq[nums[right]] || freq[nums[right]] === 0) {
            distinct++;
        }
        freq[nums[right]] = (freq[nums[right]] || 0) + 1;

        while (distinct > k) {
            freq[nums[left]]--;
            if (freq[nums[left]] === 0) {
                distinct--;
            }
            left++;
        }

        count += right - left + 1;
        if (count >= required) {
            return true;
        }
    }

    return count >= required;
}