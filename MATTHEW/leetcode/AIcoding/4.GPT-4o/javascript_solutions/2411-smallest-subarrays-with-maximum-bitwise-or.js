function smallestSubarrays(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let maxOr = 0;
        let j = i;
        while (j < n) {
            maxOr |= nums[j];
            if (maxOr === nums[i]) break;
            j++;
        }
        result[i] = j - i + 1;
    }

    return result;
}