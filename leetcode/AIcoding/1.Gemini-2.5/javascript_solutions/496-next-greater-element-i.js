var nextGreaterElement = function(nums1, nums2) {
    const nextGreaterMap = new Map();
    const stack = [];

    for (let i = 0; i < nums2.length; i++) {
        const num = nums2[i];
        while (stack.length > 0 && num > stack[stack.length - 1]) {
            nextGreaterMap.set(stack.pop(), num);
        }
        stack.push(num);
    }

    const result = new Array(nums1.length);
    for (let i = 0; i < nums1.length; i++) {
        result[i] = nextGreaterMap.has(nums1[i]) ? nextGreaterMap.get(nums1[i]) : -1;
    }

    return result;
};