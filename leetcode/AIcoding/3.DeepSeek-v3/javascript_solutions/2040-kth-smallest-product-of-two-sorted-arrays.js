var kthSmallestProduct = function(nums1, nums2, k) {
    function countLessOrEqual(target) {
        let count = 0;
        for (const num of nums1) {
            if (num > 0) {
                let left = 0, right = nums2.length;
                while (left < right) {
                    const mid = Math.floor((left + right) / 2);
                    if (num * nums2[mid] <= target) {
                        left = mid + 1;
                    } else {
                        right = mid;
                    }
                }
                count += left;
            } else if (num < 0) {
                let left = 0, right = nums2.length;
                while (left < right) {
                    const mid = Math.floor((left + right) / 2);
                    if (num * nums2[mid] <= target) {
                        right = mid;
                    } else {
                        left = mid + 1;
                    }
                }
                count += nums2.length - left;
            } else {
                if (0 <= target) {
                    count += nums2.length;
                }
            }
        }
        return count;
    }

    let left = -1e10, right = 1e10;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const cnt = countLessOrEqual(mid);
        if (cnt < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};