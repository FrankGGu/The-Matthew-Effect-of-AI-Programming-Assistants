var xorGame = function(nums) {
    let totalXor = 0;
    for (let num of nums) {
        totalXor ^= num;
    }
    return totalXor === 0 || nums.length % 2 === 0;
};