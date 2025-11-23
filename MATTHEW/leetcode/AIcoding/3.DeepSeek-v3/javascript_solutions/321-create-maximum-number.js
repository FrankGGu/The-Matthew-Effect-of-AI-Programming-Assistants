var maxNumber = function(nums1, nums2, k) {
    function getMaxSubsequence(nums, k) {
        let stack = [];
        let drop = nums.length - k;
        for (let num of nums) {
            while (drop > 0 && stack.length && stack[stack.length - 1] < num) {
                stack.pop();
                drop--;
            }
            stack.push(num);
        }
        return stack.slice(0, k);
    }

    function merge(a, b) {
        let result = [];
        while (a.length || b.length) {
            let bigger = a > b ? a : b;
            result.push(bigger[0]);
            bigger.shift();
        }
        return result;
    }

    let max = [];
    for (let i = 0; i <= k; i++) {
        if (i <= nums1.length && k - i <= nums2.length) {
            let subsequence1 = getMaxSubsequence(nums1, i);
            let subsequence2 = getMaxSubsequence(nums2, k - i);
            let current = merge(subsequence1, subsequence2);
            if (current > max) max = current;
        }
    }
    return max;
};