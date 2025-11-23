var lenLongestFibSubseq = function(arr) {
    const n = arr.length;

    // numMap stores the value-to-index mapping for quick lookups.
    // This allows checking if a number exists in arr and getting its index in O(1) time.
    const numMap = new Map();
    for (let i = 0; i < n; i++) {
        numMap.set(arr[i], i);
    }

    // dp[i][j] stores the length of the longest Fibonacci-like subsequence
    // ending with arr[i] and arr[j], where i < j.
    // Initialize with 0. A value of 0 means no Fibonacci-like subsequence
    // of length >= 3 has been found ending with arr[i] and arr[j].
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    // maxLength will store the maximum length found across all possible subsequences.
    let maxLength = 0;

    // Iterate through all possible pairs (arr[i], arr[j]) where arr[j] is the last element
    // and arr[i] is the second-to-last element of a Fibonacci-like subsequence.
    for (let j = 0; j < n; j++) {
        for (let i = 0; i < j; i++) {
            // We are looking for a third element arr[k] such that arr[k] + arr[i] = arr[j].
            // This means arr[k] = arr[j] - arr[i].
            const prevNum = arr[j] - arr[i];

            // For arr[k], arr[i], arr[j] to be a valid Fibonacci-like subsequence:
            // 1. arr[k] must exist in the array.
            // 2. arr[k] must be strictly less than arr[i] (since arr is strictly increasing,
            //    this ensures k < i).
            if (prevNum < arr[i]) {
                const k = numMap.get(prevNum);

                // If prevNum exists and its index k is less than i:
                if (k !== undefined && k < i) {
                    // If arr[k] and arr[i] already formed a Fibonacci-like subsequence
                    // (i.e., dp[k][i] > 0), then we extend that sequence.
                    // Otherwise, arr[k], arr[i], arr[j] form a new Fibonacci-like subsequence of length 3.
                    dp[i][j] = (dp[k][i] > 0 ? dp[k][i] : 2) + 1;

                    // Update the overall maximum length found.
                    maxLength = Math.max(maxLength, dp[i][j]);
                }
            }
        }
    }

    // If maxLength remains 0, it means no Fibonacci-like subsequence of length >= 3 was found.
    // In this case, the problem asks to return 0.
    return maxLength;
};