var maxNumber = function(nums1, nums2, k) {

    const maxArray = (nums, count) => {
        if (count === 0) return [];
        const stack = [];
        let drop = nums.length - count;
        for (const num of nums) {
            while (stack.length > 0 && num > stack[stack.length - 1] && drop > 0) {
                stack.pop();
                drop--;
            }
            stack.push(num);
        }
        return stack.slice(0, count);
    };

    const merge = (arr1, arr2) => {
        const result = [];
        let p1 = 0;
        let p2 = 0;
        while (p1 < arr1.length || p2 < arr2.length) {
            if (compare(arr1, p1, arr2, p2)) {
                result.push(arr1[p1++]);
            } else {
                result.push(arr2[p2++]);
            }
        }
        return result;
    };

    const compare = (arr1, idx1, arr2, idx2) => {
        while (idx1 < arr1.length && idx2 < arr2.length) {
            if (arr1[idx1] > arr2[idx2]) return true;
            if (arr1[idx1] < arr2[idx2]) return false;
            idx1++;
            idx2++;
        }
        return arr1.length - idx1 > arr2.length - idx2;
    };

    let maxResult = [];

    for (let i = Math.max(0, k - nums2.length); i <= Math.min(k, nums1.length); i++) {
        const sub1 = maxArray(nums1, i);
        const sub2 = maxArray(nums2, k - i);
        const currentMerged = merge(sub1, sub2);

        if (compare(currentMerged, 0, maxResult, 0)) {
            maxResult = currentMerged;
        }
    }

    return maxResult;
};