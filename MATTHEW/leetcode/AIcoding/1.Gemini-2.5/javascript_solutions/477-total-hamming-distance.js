var totalHammingDistance = function(nums) {
    let totalDistance = 0;
    const n = nums.length;

    for (let i = 0; i < 31; i++) {
        let count0 = 0;
        let count1 = 0;

        for (let j = 0; j < n; j++) {
            if ((nums[j] >> i) & 1) {
                count1++;
            } else {
                count0++;
            }
        }
        totalDistance += count0 * count1;
    }

    return totalDistance;
};