var xorAllNums = function(nums1, nums2) {
    let n = nums1.length;
    let m = nums2.length;

    let xor1 = 0;
    for (let i = 0; i < n; i++) {
        xor1 ^= nums1[i];
    }

    let xor2 = 0;
    for (let i = 0; i < m; i++) {
        xor2 ^= nums2[i];
    }

    if (n % 2 === 0 && m % 2 === 0) {
        return 0;
    } else if (n % 2 === 0 && m % 2 === 1) {
        return xor1;
    } else if (n % 2 === 1 && m % 2 === 0) {
        return xor2;
    } else { // n % 2 === 1 && m % 2 === 1
        return xor1 ^ xor2;
    }
};