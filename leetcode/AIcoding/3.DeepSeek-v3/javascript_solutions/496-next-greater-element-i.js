var nextGreaterElement = function(nums1, nums2) {
    let stack = [];
    let map = new Map();

    for (let num of nums2) {
        while (stack.length && stack[stack.length - 1] < num) {
            map.set(stack.pop(), num);
        }
        stack.push(num);
    }

    let result = [];
    for (let num of nums1) {
        result.push(map.has(num) ? map.get(num) : -1);
    }

    return result;
};