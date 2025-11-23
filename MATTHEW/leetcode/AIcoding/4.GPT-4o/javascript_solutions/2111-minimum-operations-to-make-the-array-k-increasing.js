function minOperations(A, k) {
    const n = A.length;
    let totalOperations = 0;

    for (let i = 0; i < k; i++) {
        const subsequence = [];

        for (let j = i; j < n; j += k) {
            subsequence.push(A[j]);
        }

        totalOperations += subsequence.length - longestNonDecreasingSubsequence(subsequence);
    }

    return totalOperations;
}

function longestNonDecreasingSubsequence(arr) {
    const dp = [];

    for (const num of arr) {
        let left = 0, right = dp.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] <= num) left = mid + 1;
            else right = mid;
        }
        dp[left] = num;
    }

    return dp.length;
}