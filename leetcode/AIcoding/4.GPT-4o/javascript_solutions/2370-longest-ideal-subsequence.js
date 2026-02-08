function longestIdealSubstring(s, k) {
    const dp = new Array(128).fill(0);
    let maxLength = 0;

    for (const char of s) {
        const index = char.charCodeAt(0);
        let currentLength = 1;

        for (let j = Math.max(0, index - k); j <= Math.min(127, index + k); j++) {
            currentLength = Math.max(currentLength, dp[j] + 1);
        }

        dp[index] = Math.max(dp[index], currentLength);
        maxLength = Math.max(maxLength, dp[index]);
    }

    return maxLength;
}