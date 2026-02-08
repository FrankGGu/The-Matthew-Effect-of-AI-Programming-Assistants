const totalStrength = function(strength) {
    const MOD = 1e9 + 7;
    const n = strength.length;
    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && strength[stack[stack.length - 1]] >= strength[i]) {
            stack.pop();
        }
        if (stack.length) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && strength[stack[stack.length - 1]] > strength[i]) {
            stack.pop();
        }
        if (stack.length) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    const prefixSum = new Array(n + 2).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    const prefixPrefix = new Array(n + 2).fill(0);
    for (let i = 0; i <= n; i++) {
        prefixPrefix[i + 1] = (prefixPrefix[i] + prefixSum[i]) % MOD;
    }

    let res = 0;
    for (let i = 0; i < n; i++) {
        const l = left[i] + 1;
        const r = right[i] - 1;
        const total = (prefixPrefix[r + 2] - prefixPrefix[i + 1] + MOD) % MOD;
        const total2 = (prefixPrefix[i + 1] - prefixPrefix[l] + MOD) % MOD;
        const sum = (total * (i - l + 1) - total2 * (r - i + 1) % MOD;
        res = (res + sum * strength[i]) % MOD;
    }

    return (res + MOD) % MOD;
};