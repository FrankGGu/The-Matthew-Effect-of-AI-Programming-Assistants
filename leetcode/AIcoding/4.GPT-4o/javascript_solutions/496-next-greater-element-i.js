var nextGreaterElement = function(nums1, nums2) {
    const map = new Map();
    const stack = [];

    for (const num of nums2) {
        while (stack.length && stack[stack.length - 1] < num) {
            map.set(stack.pop(), num);
        }
        stack.push(num);
    }

    return nums1.map(num => map.get(num) || -1);
};