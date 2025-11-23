var purchasePlans = function(nums1, nums2, target) {
    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => a - b);

    let count = 0;
    let j = nums2.length - 1;
    const MOD = 1000000007;

    for (let i = 0; i < nums1.length; i++) {
        while (j >= 0 && nums1[i] + nums2[j] > target) {
            j--;
        }
        if (j < 0) {
            break;
        }
        count = (count + (j + 1)) % MOD;
    }

    return count;
};