var sumSubarrayMins = function(arr) {
    const MOD = 10**9 + 7;
    const n = arr.length;

    const left = new Array(n);
    const right = new Array(n);

    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] >= arr[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? i + 1 : i - stack[stack.length - 1];
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] > arr[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? n - i : stack[stack.length - 1] - i;
        stack.push(i);
    }

    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        const term = (arr[i] * left[i]) % MOD;
        totalSum = (totalSum + (term * right[i]) % MOD) % MOD;
    }

    return totalSum;
};