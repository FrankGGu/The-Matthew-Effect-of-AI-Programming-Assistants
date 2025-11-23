var maxPalindromes = function(s, k) {
    const n = s.length;
    let dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = i; j >= 1; j--) {
            const sub = s.substring(j - 1, i);
            if (isPalindrome(sub) && sub.length >= k) {
                dp[i] = Math.max(dp[i], dp[j - 1] + 1);
            }
        }
    }

    return dp[n];

    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};