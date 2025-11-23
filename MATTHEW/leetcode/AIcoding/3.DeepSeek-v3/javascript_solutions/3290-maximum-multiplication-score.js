var maximumScore = function(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        if (stack.length) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && nums[stack[stack.length - 1]] > nums[i]) {
            stack.pop();
        }
        if (stack.length) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    const pairs = nums.map((num, i) => [num, i]);
    pairs.sort((a, b) => b[0] - a[0]);

    let result = 1;
    const mod = 1e9 + 7;

    for (const [num, i] of pairs) {
        const l = left[i];
        const r = right[i];
        const count = (i - l) * (r - i);
        const take = Math.min(count, k);
        result = (result * BigInt(Math.pow(num, take))) % BigInt(mod);
        k -= take;
        if (k === 0) break;
    }

    return result;
};