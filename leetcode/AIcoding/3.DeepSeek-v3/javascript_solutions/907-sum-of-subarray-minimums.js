var sumSubarrayMins = function(arr) {
    const MOD = 1e9 + 7;
    const stack = [];
    const left = new Array(arr.length).fill(0);
    const right = new Array(arr.length).fill(0);

    for (let i = 0; i < arr.length; i++) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] > arr[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? i + 1 : i - stack[stack.length - 1];
        stack.push(i);
    }

    stack.length = 0;

    for (let i = arr.length - 1; i >= 0; i--) {
        while (stack.length > 0 && arr[stack[stack.length - 1]] >= arr[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? arr.length - i : stack[stack.length - 1] - i;
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < arr.length; i++) {
        result = (result + arr[i] * left[i] * right[i]) % MOD;
    }

    return result;
};