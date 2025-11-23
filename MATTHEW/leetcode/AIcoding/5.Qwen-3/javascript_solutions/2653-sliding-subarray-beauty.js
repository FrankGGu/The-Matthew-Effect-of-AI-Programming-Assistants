function sumOfSubarrayMinimums(A) {
    const MOD = 10**9 + 7;
    const N = A.length;
    const left = new Array(N).fill(-1);
    const right = new Array(N).fill(N);
    const stack = [];

    for (let i = 0; i < N; ++i) {
        while (stack.length && A[stack[stack.length - 1]] >= A[i]) {
            stack.pop();
        }
        if (stack.length) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = N - 1; i >= 0; --i) {
        while (stack.length && A[stack[stack.length - 1]] > A[i]) {
            stack.pop();
        }
        if (stack.length) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < N; ++i) {
        const count = (i - left[i]) * (right[i] - i);
        result = (result + A[i] * count) % MOD;
    }

    return result;
}