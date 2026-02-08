function numberOfSubarrays(nums, k) {
    const countAtMostK = (k) => {
        let left = 0, count = 0, oddCount = 0;
        for (let right = 0; right < nums.length; right++) {
            if (nums[right] % 2 === 1) oddCount++;
            while (oddCount > k) {
                if (nums[left] % 2 === 1) oddCount--;
                left++;
            }
            count += right - left + 1;
        }
        return count;
    };
    return countAtMostK(k) - countAtMostK(k - 1);
}