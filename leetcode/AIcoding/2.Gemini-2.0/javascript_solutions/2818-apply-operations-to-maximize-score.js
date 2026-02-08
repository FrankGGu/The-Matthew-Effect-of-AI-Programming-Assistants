var maximumScore = function(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] < nums[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? 0 : stack[stack.length - 1] + 1;
        stack.push(i);
    }

    stack.length = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] <= nums[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? n - 1 : stack[stack.length - 1] - 1;
        stack.push(i);
    }

    const segments = [];
    for (let i = 0; i < n; i++) {
        segments.push([nums[i], left[i], right[i]]);
    }

    segments.sort((a, b) => b[0] - a[0]);

    let ans = 1n;
    let operations = 0;
    const MOD = 1000000007n;

    for (const [val, l, r] of segments) {
        const len = r - l + 1;
        const take = Math.min(k - operations, len);
        ans = (ans * BigInt(val) ** BigInt(take)) % MOD;
        operations += take;
        if (operations === k) break;
    }

    return Number(ans);
};