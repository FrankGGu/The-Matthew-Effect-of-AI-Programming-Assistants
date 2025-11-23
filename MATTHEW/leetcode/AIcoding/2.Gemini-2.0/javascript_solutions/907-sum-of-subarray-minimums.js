var sumSubarrayMins = function(arr) {
    const MOD = 10**9 + 7;
    const n = arr.length;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);
    let stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] > arr[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? i + 1 : i - stack[stack.length - 1];
        stack.push(i);
    }

    stack = [];
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] >= arr[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? n - i : stack[stack.length - 1] - i;
        stack.push(i);
    }

    let ans = 0;
    for (let i = 0; i < n; i++) {
        ans = (ans + arr[i] * left[i] * right[i]) % MOD;
    }

    return ans;
};