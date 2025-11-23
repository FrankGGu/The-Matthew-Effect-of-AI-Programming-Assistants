var minimumTotalCost = function(nums1, nums2) {
    let n = nums1.length;
    let total = 0;
    let count = {};
    let maxCount = 0;
    let maxNum = -1;
    let res = 0;

    for (let i = 0; i < n; i++) {
        if (nums1[i] === nums2[i]) {
            total++;
            let num = nums1[i];
            count[num] = (count[num] || 0) + 1;
            if (count[num] > maxCount) {
                maxCount = count[num];
                maxNum = num;
            }
            res += i;
        }
    }

    if (maxCount > total / 2) {
        let needed = 2 * maxCount - total;
        for (let i = 0; i < n && needed > 0; i++) {
            if (nums1[i] !== nums2[i] && nums1[i] !== maxNum && nums2[i] !== maxNum) {
                res += i;
                needed--;
            }
        }
        if (needed > 0) {
            return -1;
        }
    }

    return res;
};