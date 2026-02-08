var countPairs = function(nums, low, high) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            let xor = nums[i] ^ nums[j];
            if (xor >= low && xor <= high) {
                count++;
            }
        }
    }
    return count;
};