var countTriplets = function(nums) {
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if ((nums[i] ^ nums[j] ^ nums[k]) === 0) {
                    count++;
                }
            }
        }
    }

    return count;
};