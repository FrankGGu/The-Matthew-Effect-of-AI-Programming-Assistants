var maxNumber = function(nums1, nums2, k) {
    function pickMax(nums, k) {
        const stack = [];
        const drop = nums.length - k;
        for (let i = 0; i < nums.length; i++) {
            while (stack.length > 0 && drop > 0 && stack[stack.length - 1] < nums[i]) {
                stack.pop();
                drop--;
            }
            stack.push(nums[i]);
        }
        return stack.slice(0, k);
    }

    function merge(nums1, nums2) {
        const res = [];
        let i = 0, j = 0;
        while (i < nums1.length || j < nums2.length) {
            if (greater(nums1, i, nums2, j)) {
                res.push(nums1[i]);
                i++;
            } else {
                res.push(nums2[j]);
                j++;
            }
        }
        return res;
    }

    function greater(nums1, i, nums2, j) {
        while (i < nums1.length && j < nums2.length && nums1[i] === nums2[j]) {
            i++;
            j++;
        }
        return j === nums2.length || (i < nums1.length && nums1[i] > nums2[j]);
    }

    let res = [];
    for (let i = Math.max(0, k - nums2.length); i <= Math.min(k, nums1.length); i++) {
        const s1 = pickMax(nums1, i);
        const s2 = pickMax(nums2, k - i);
        const merged = merge(s1, s2);
        if (greater(merged, 0, res, 0)) {
            res = merged;
        }
    }
    return res;
};