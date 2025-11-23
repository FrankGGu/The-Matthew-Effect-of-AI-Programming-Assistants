function countTriplets(nums) {
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            for (let k = 0; k < n; k++) {
                if ((nums[i] & nums[j] & nums[k]) === 0) {
                    count++;
                }
            }
        }
    }

    return count;
}