var minSum = function(nums1, nums2) {
    let sum1 = 0, countZero1 = 0;
    for (let num of nums1) {
        if (num === 0) {
            countZero1++;
        } else {
            sum1 += num;
        }
    }

    let sum2 = 0, countZero2 = 0;
    for (let num of nums2) {
        if (num === 0) {
            countZero2++;
        } else {
            sum2 += num;
        }
    }

    const min1 = sum1 + countZero1;
    const min2 = sum2 + countZero2;

    if (min1 > min2) {
        if (countZero2 === 0) {
            return -1;
        }
    } else if (min1 < min2) {
        if (countZero1 === 0) {
            return -1;
        }
    }

    return Math.max(min1, min2);
};