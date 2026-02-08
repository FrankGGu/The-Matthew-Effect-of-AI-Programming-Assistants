var minNumber = function(nums1, nums2) {
    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => a - b);

    let min1 = nums1[0];
    let min2 = nums2[0];

    let smallestCommon = Infinity;

    let p1 = 0;
    let p2 = 0;
    while (p1 < nums1.length && p2 < nums2.length) {
        if (nums1[p1] === nums2[p2]) {
            smallestCommon = nums1[p1];
            break;
        } else if (nums1[p1] < nums2[p2]) {
            p1++;
        } else {
            p2++;
        }
    }

    let result = Infinity;

    if (smallestCommon !== Infinity) {
        result = Math.min(result, smallestCommon);
    }

    let twoDigitNumber = Math.min(min1, min2) * 10 + Math.max(min1, min2);
    result = Math.min(result, twoDigitNumber);

    return result;
};