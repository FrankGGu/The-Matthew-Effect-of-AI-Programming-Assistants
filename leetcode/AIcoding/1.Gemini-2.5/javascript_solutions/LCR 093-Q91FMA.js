var lenLongestFibSubsequence = function(arr) {
    const n = arr.length;
    const valToIndex = new Map();
    for (let i = 0; i < n; i++) {
        valToIndex.set(arr[i], i);
    }

    // dp[i][j] stores the length of the longest Fibonacci-like subsequence
    // ending with arr[i] and arr[j], where arr[i] is the second to last element
    // and arr[j] is the last element.
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));
    let maxLength = 0;

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < j; i++) {
            // We are looking for a previous element 'prevVal' such that prevVal + arr[i] = arr[j]
            // and prevVal < arr[i].
            const prevVal = arr[j] - arr[i];

            if (prevVal < arr[i] && valToIndex.has(prevVal)) {
                const k = valToIndex.get(prevVal);
                // The length of the Fibonacci-like subsequence ending with arr[k], arr[i], arr[j]
                // is 1 more than the length of the subsequence ending with arr[k], arr[i].
                // If dp[k][i] is 0, it means arr[k], arr[i] is not part of a known
                // Fibonacci-like subsequence of length >= 3. In this case, arr[k], arr[i], arr[j]
                // forms a new subsequence of length 3.
                dp[i][j] = (dp[k][i] || 2) + 1;
                maxLength = Math.max(maxLength, dp[i][j]);
            }
        }
    }

    return maxLength;
};