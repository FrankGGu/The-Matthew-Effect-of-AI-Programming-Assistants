function countSubarrays(nums) {
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let minVal = nums[i];
        for (let j = i; j < n; j++) {
            minVal = Math.min(minVal, nums[j]);
            if (minVal === nums[i]) {
                count++;
            } else {
                break;
            }
        }
    }

    return count;
}