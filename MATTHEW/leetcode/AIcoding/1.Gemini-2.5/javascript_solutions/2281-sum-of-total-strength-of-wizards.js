var totalStrength = function(strength) {
    const n = strength.length;
    const MOD = 10**9 + 7;

    // 1. Calculate prefix sums
    // prefixSum[i] = strength[0] + ... + strength[i-1]
    // prefixSum[0] = 0
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    // 2. Calculate prefix sums of prefix sums
    // prefixPrefixSum[i] = prefixSum[0] + ... + prefixSum[i-1]
    // prefixPrefixSum[0] = 0
    const prefixPrefixSum = new Array(n + 2).fill(0);
    for (let i = 0; i <= n; i++) {
        prefixPrefixSum[i + 1] = (prefixPrefixSum[i] + prefixSum[i]) % MOD;
    }

    // 3. Find previous strictly smaller element (ps)
    // ps[i] = index of largest j < i such that strength[j] < strength[i]
    // If no such element, ps[i] = -1
    const ps = new Array(n).fill(-1);
    const stack = []; // Stores indices in increasing order of strength values
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] >= strength[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            ps[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    // 4. Find next smaller or equal element (nse)
    // nse[i] = index of smallest k > i such that strength[k] <= strength[i]
    // If no such element, nse[i] = n
    const nse = new Array(n).fill(n);
    stack.length = 0; // Clear the stack
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] > strength[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            nse[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    // 5. Calculate total strength
    let total = 0;
    for (let i = 0; i < n; i++) {
        const L = ps[i] + 1; // Left boundary for subarray start index (inclusive)
        const R = nse[i] - 1; // Right boundary for subarray end index (inclusive)

        // Number of elements to the left of i (inclusive)
        const countLeft = i - L + 1;
        // Number of elements to the right of i (inclusive)
        const countRight = R - i + 1;

        // Sum of prefix sums for subarrays ending at k (from i to R)
        // sum_{k=i to R} prefixSum[k+1] = prefixPrefixSum[R+2] - prefixPrefixSum[i+1]
        let sumK = (prefixPrefixSum[R + 2] - prefixPrefixSum[i + 1] + MOD) % MOD;

        // Sum of prefix sums for subarrays starting at j (from L to i)
        // sum_{j=L to i} prefixSum[j] = prefixPrefixSum[i+1] - prefixPrefixSum[L]
        let sumJ = (prefixPrefixSum[i + 1] - prefixPrefixSum[L] + MOD) % MOD;

        // Contribution of strength[i] as the minimum
        // strength[i] * [countLeft * sumK - countRight * sumJ]
        let term1 = (countLeft * sumK) % MOD;
        let term2 = (countRight * sumJ) % MOD;

        let innerSum = (term1 - term2 + MOD) % MOD;
        let contribution = (strength[i] * innerSum) % MOD;

        total = (total + contribution) % MOD;
    }

    return total;
};