var minimumAddedInteger = function(nums1, nums2) {
    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => a - b);

    const check = (x) => {
        let i = 0, j = 0, skip = 0;
        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] + x === nums2[j]) {
                i++;
                j++;
            } else {
                i++;
                skip++;
                if (skip > 2) return false;
            }
        }
        return j === nums2.length;
    };

    const candidates = [
        nums2[0] - nums1[0],
        nums2[0] - nums1[1],
        nums2[0] - nums1[2]
    ];

    for (const x of candidates) {
        if (check(x)) {
            return x;
        }
    }

    return -1;
};