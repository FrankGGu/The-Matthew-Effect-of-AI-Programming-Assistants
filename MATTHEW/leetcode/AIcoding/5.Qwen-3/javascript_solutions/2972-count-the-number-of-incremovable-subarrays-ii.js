function countSubarrays(nums) {
    const n = nums.length;
    let result = 0;

    for (let i = 0; i < n; i++) {
        let max = nums[i];
        for (let j = i; j < n; j++) {
            if (nums[j] > max) {
                max = nums[j];
                result++;
            } else {
                break;
            }
        }
    }

    return result;
}