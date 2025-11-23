var nextGreaterElement = function(nums1, nums2) {
    const map = new Map();
    const stack = [];

    for (let i = 0; i < nums2.length; i++) {
        while (stack.length > 0 && nums2[i] > stack[stack.length - 1]) {
            map.set(stack.pop(), nums2[i]);
        }
        stack.push(nums2[i]);
    }

    const result = [];
    for (let num of nums1) {
        result.push(map.get(num) || -1);
    }

    return result;
};