var minSum = function(nums1, nums2) {
    let sum1 = 0;
    let hasZero1 = false;
    for (let num of nums1) {
        sum1 += num;
        if (num === 0) {
            hasZero1 = true;
            sum1 += 1;
        }
    }

    let sum2 = 0;
    let hasZero2 = false;
    for (let num of nums2) {
        sum2 += num;
        if (num === 0) {
            hasZero2 = true;
            sum2 += 1;
        }
    }

    if (hasZero1 && hasZero2) {
        return Math.max(sum1, sum2);
    } else if (hasZero1) {
        if (sum1 > sum2) {
            return sum1;
        } else {
            return -1;
        }
    } else if (hasZero2) {
        if (sum2 > sum1) {
            return sum2;
        } else {
            return -1;
        }
    } else {
        if (sum1 === sum2) {
            return sum1;
        } else {
            return -1;
        }
    }
};