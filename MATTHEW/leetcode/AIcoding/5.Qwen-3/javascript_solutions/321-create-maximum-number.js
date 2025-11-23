function maxNumber(nums1, nums2) {
    function getDigits(nums, k) {
        let result = [];
        let toRemove = nums.length - k;
        for (let num of nums) {
            while (toRemove > 0 && result.length > 0 && result[result.length - 1] < num) {
                result.pop();
                toRemove--;
            }
            result.push(num);
        }
        return result.slice(0, k);
    }

    function merge(a, b) {
        let result = [];
        let i = 0, j = 0;
        while (i < a.length || j < b.length) {
            if (i < a.length && j < b.length) {
                if (a[i] > b[j]) {
                    result.push(a[i++]);
                } else {
                    result.push(b[j++]);
                }
            } else if (i < a.length) {
                result.push(a[i++]);
            } else {
                result.push(b[j++]);
            }
        }
        return result;
    }

    let max = [];
    let len1 = nums1.length;
    let len2 = nums2.length;
    for (let k = Math.max(0, len1 + len2 - 100); k <= Math.min(len1, len2); k++) {
        let digits1 = getDigits(nums1, k);
        let digits2 = getDigits(nums2, len1 + len2 - k);
        let current = merge(digits1, digits2);
        if (current.length > max.length || (current.length === max.length && current.join('') > max.join(''))) {
            max = current;
        }
    }
    return max;
}