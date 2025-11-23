var sumSubarrayMin = function(A) {
    const mod = 1e9 + 7;
    const n = A.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && A[stack[stack.length - 1]] > A[i]) {
            right[stack.pop()] = i;
        }
        stack.push(i);
    }
    while (stack.length) {
        right[stack.pop()] = n;
    }

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && A[stack[stack.length - 1]] >= A[i]) {
            left[stack.pop()] = i;
        }
        stack.push(i);
    }
    while (stack.length) {
        left[stack.pop()] = -1;
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result = (result + A[i] * (i - left[i]) * (right[i] - i)) % mod;
    }

    return result;
};