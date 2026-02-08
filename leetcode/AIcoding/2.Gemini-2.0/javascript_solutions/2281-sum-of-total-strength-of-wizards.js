var sumOfTotalStrength = function(strength) {
    const n = strength.length;
    const MOD = 10**9 + 7;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);
    let stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] > strength[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? -1 : stack[stack.length - 1];
        stack.push(i);
    }

    stack = [];
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] >= strength[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? n : stack[stack.length - 1];
        stack.push(i);
    }

    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    let prefixSum2 = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum2[i + 1] = (prefixSum2[i] + prefixSum[i + 1]) % MOD;
    }

    let ans = 0;
    for (let i = 0; i < n; i++) {
        let l = left[i];
        let r = right[i];
        let leftCount = i - l;
        let rightCount = r - i;

        let leftSum = ((prefixSum2[i] - prefixSum2[Math.max(0, l)]) % MOD - ((Math.max(0, l) * (prefixSum[i] - prefixSum[Math.max(0, l)]) % MOD)) % MOD + MOD) % MOD;
        let rightSum = ((Math.max(0, i+1) * (prefixSum[r] - prefixSum[i+1]) % MOD) % MOD - (prefixSum2[r] - prefixSum2[i+1] + MOD) % MOD + MOD) % MOD;
        let totalSum = (leftSum * rightCount % MOD + rightSum * leftCount % MOD) % MOD;
        ans = (ans + totalSum * strength[i] % MOD) % MOD;
    }

    return ans;
};