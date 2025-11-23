var totalStrength = function(strength) {
    const MOD = 10**9 + 7;
    const n = strength.length;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);
    let stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && strength[stack[stack.length - 1]] < strength[i]) {
            stack.pop();
        }
        left[i] = stack.length ? stack[stack.length - 1] + 1 : 0;
        stack.push(i);
    }

    stack = [];
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && strength[stack[stack.length - 1]] <= strength[i]) {
            stack.pop();
        }
        right[i] = stack.length ? stack[stack.length - 1] : n;
        stack.push(i);
    }

    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        let total = (prefixSum[right[i]] - prefixSum[left[i]] + MOD) % MOD;
        result = (result + total * strength[i]) % MOD;
    }

    return result;
};