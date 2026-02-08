var kthSmallestProduct = function(nums1, nums2, k) {
    const count = (mid) => {
        let cnt = 0;
        for (let i = 0; i < nums1.length; i++) {
            if (nums1[i] >= 0) {
                let l = 0, r = nums2.length - 1;
                while (l <= r) {
                    let m = Math.floor((l + r) / 2);
                    if (nums1[i] * nums2[m] <= mid) {
                        l = m + 1;
                    } else {
                        r = m - 1;
                    }
                }
                cnt += l;
            } else {
                let l = 0, r = nums2.length - 1;
                while (l <= r) {
                    let m = Math.floor((l + r) / 2);
                    if (nums1[i] * nums2[m] <= mid) {
                        r = m - 1;
                    } else {
                        l = m + 1;
                    }
                }
                cnt += nums2.length - l;
            }
        }
        return cnt;
    }

    let l = -10 ** 10, r = 10 ** 10;
    while (l < r) {
        let mid = Math.floor((l + r) / 2);
        if (count(mid) < k) {
            l = mid + 1;
        } else {
            r = mid;
        }
    }
    return l;
};