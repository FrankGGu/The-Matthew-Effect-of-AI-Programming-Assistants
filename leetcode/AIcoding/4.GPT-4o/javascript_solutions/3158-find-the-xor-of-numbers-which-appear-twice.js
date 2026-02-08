var findDuplicate = function(nums) {
    let xor = 0;
    for (let num of nums) {
        xor ^= num;
    }
    return xor;
};