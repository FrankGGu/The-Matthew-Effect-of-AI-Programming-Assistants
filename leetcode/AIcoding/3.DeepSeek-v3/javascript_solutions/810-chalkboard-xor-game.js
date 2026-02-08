var xorGame = function(nums) {
    let xor = 0;
    for (const num of nums) {
        xor ^= num;
    }
    return xor === 0 || nums.length % 2 === 0;
};