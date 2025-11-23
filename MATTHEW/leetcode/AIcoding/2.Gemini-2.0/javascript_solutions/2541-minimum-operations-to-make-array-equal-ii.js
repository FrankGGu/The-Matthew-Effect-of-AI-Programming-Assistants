var minOperations = function(nums1, nums2, k) {
    if (k === 0) {
        if (nums1.every((val, index) => val === nums2[index])) {
            return 0;
        } else {
            return -1;
        }
    }

    let posSum = 0;
    let negSum = 0;

    for (let i = 0; i < nums1.length; i++) {
        let diff = nums1[i] - nums2[i];
        if (diff % k !== 0) {
            return -1;
        }

        let ops = diff / k;

        if (ops > 0) {
            posSum += ops;
        } else if (ops < 0) {
            negSum += Math.abs(ops);
        }
    }

    if (posSum === negSum) {
        return posSum;
    } else {
        return -1;
    }
};