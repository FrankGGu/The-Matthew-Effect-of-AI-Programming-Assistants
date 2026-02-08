function sumSubarrayMins(arr) {
    const MOD = 1000000007;
    const n = arr.length;
    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] >= arr[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] > arr[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        const l = left[i];
        const r = right[i];
        const count = (i - l) * (r - i);
        result = (result + arr[i] * count) % MOD;
    }

    return result;
}