var minSum = function(nums1, nums2) {
    let sum1 = 0;
    let zeros1 = 0;
    for (const num of nums1) {
        if (num === 0) {
            zeros1++;
        } else {
            sum1 += num;
        }
    }

    let sum2 = 0;
    let zeros2 = 0;
    for (const num of nums2) {
        if (num === 0) {
            zeros2++;
        } else {
            sum2 += num;
        }
    }

    const minPossibleSum1 = sum1 + zeros1;
    const minPossibleSum2 = sum2 + zeros2;

    if (zeros1 === 0 && zeros2 === 0) {
        if (sum1 === sum2) {
            return sum1;
        } else {
            return -1;
        }
    } else if (zeros1 === 0) { // zeros2 > 0
        if (sum1 >= minPossibleSum2) {
            return sum1;
        } else {
            return -1;
        }
    } else if (zeros2 === 0) { // zeros1 > 0
        if (sum2 >= minPossibleSum1) {
            return sum2;
        } else {
            return -1;
        }
    } else { // zeros1 > 0 and zeros2 > 0
        return Math.max(minPossibleSum1, minPossibleSum2);
    }
};