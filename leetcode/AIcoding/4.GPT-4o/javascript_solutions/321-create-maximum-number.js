var maxNumber = function(nums1, nums2, k) {
    const merge = (arr1, arr2) => {
        const result = [];
        while (arr1.length || arr2.length) {
            if (arr1[0] > arr2[0]) {
                result.push(arr1.shift());
            } else {
                result.push(arr2.shift());
            }
        }
        return result;
    };

    const getMaxArray = (nums, len) => {
        const stack = [];
        const drop = nums.length - len;
        for (const num of nums) {
            while (drop && stack.length && stack[stack.length - 1] < num) {
                stack.pop();
                drop--;
            }
            stack.push(num);
        }
        return stack.slice(0, len);
    };

    let maxResult = [];
    for (let i = Math.max(0, k - nums2.length); i <= Math.min(k, nums1.length); i++) {
        const part1 = getMaxArray(nums1, i);
        const part2 = getMaxArray(nums2, k - i);
        const candidate = merge(part1, part2);
        maxResult = maxResult.length ? (maxResult > candidate ? maxResult : candidate) : candidate;
    }
    return maxResult;
};