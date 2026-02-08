class Solution {
    longestPrefix(s) {
        const n = s.length;
        const lps = Array(n).fill(0);
        let j = 0;

        for (let i = 1; i < n; i++) {
            while (j > 0 && s[i] !== s[j]) {
                j = lps[j - 1];
            }
            if (s[i] === s[j]) {
                j++;
                lps[i] = j;
            }
        }

        return s.substring(0, lps[n - 1]);
    }
}