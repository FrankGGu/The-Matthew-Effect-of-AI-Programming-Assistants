var getXORSum = function(nums1, nums2) {
    let xor1 = 0;
    for (let num of nums1) {
        xor1 ^= num;
    }
    let xor2 = 0;
    for (let num of nums2) {
        xor2 ^= num;
    }
    return xor1 ^ xor2;
};