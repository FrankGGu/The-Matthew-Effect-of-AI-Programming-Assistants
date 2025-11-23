var minOperations = function(nums, k) {
    let xor = 0;
    for (let num of nums) {
        xor ^= num;
    }
    let diff = xor ^ k;
    let count = 0;
    while (diff > 0) {
        count += diff & 1;
        diff >>= 1;
    }
    return count;
};