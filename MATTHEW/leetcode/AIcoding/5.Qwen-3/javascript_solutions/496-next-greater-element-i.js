function nextGreaterElement(nums1, nums2) {
    const map = new Map();
    const stack = [];

    for (const num of nums2) {
        while (stack.length > 0 && stack[stack.length - 1] < num) {
            const top = stack.pop();
            map.set(top, num);
        }
        stack.push(num);
    }

    const result = [];
    for (const num of nums1) {
        result.push(map.has(num) ? map.get(num) : -1);
    }

    return result;
}