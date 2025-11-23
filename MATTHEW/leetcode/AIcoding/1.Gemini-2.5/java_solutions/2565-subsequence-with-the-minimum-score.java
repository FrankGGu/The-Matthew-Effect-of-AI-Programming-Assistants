class Solution {
    public int minimumScore(String s, String t) {
        int n = s.length();
        int m = t.length();

        // left[k] stores the index in s where t[k] is matched,
        // assuming t[0...k] is formed greedily from left.
        // That is, left[k] is the smallest index j such that s[j] == t[k]
        // and s[0...j-1] contains t[0...k-1] as a subsequence.
        int[] left = new int[m];
        int sPtr = 0;
        for (int k = 0; k < m; k++) {
            while (sPtr < n && s.charAt(sPtr) != t.charAt(k)) {
                sPtr++;
            }
            left[k] = sPtr;
            sPtr++;
        }

        // right[k] stores the index in s where t[k] is matched,
        // assuming t[k...m-1] is formed greedily from right.
        // That is, right[k] is the largest index j such that s[j] == t[k]
        // and s[j+1...n-1] contains t[k+1...m-1] as a subsequence.
        int[] right = new int[m];
        sPtr = n - 1;
        for (int k = m - 1; k >= 0; k--) {
            while (sPtr >= 0 && s.charAt(sPtr) != t.charAt(k)) {
                sPtr--;
            }
            right[k] = sPtr;
            sPtr--;
        }

        int minScore = n; // Initialize with max possible score

        // The problem asks to find a subsequence of s that is equal to t,
        // and minimize max(indices) - min(indices) + 1.
        // Let i_0 be the first index in s used for t[0], and i_{m-1} be the last index in s used for t[m-1].
        // We want to minimize i_{m-1} - i_0 + 1.

        // Case 1: The entire string t is matched.
        // We consider t[0] matched at left[0] (earliest possible start)
        // and t[m-1] matched at right[m-1] (latest possible end).
        // The characters t[1...m-2] must be matched between left[0] and right[m-1].
        minScore = Math.min(minScore, right[m-1] - left[0] + 1);

        // Case 2: The subsequence of t starts with t[k] (matched at left[k])
        // and ends with t[m-1] (matched at right[m-1]).
        // This effectively "removes" t[0...k-1] from consideration for the start of the subsequence.
        // We iterate k from 1 to m-1, meaning t[k] is the first character of the subsequence.
        for (int k = 1; k < m; k++) {
            // The first character of the subsequence is t[k], matched at left[k].
            // The last character of the subsequence is t[m-1], matched at right[m-1].
            // This is valid as long as left[k] < right[m-1], which holds if t is a subsequence of s.
            minScore = Math.min(minScore, right[m-1] - left[k] + 1);
        }

        // Case 3: The subsequence of t starts with t[0] (matched at left[0])
        // and ends with t[m-1-k] (matched at right[m-1-k]).
        // This effectively "removes" t[m-k...m-1] from consideration for the end of the subsequence.
        // We iterate k from 1 to m-1, meaning t[m-1-k] is the last character of the subsequence.
        for (int k = 1; k < m; k++) {
            // The first character of the subsequence is t[0], matched at left[0].
            // The last character of the subsequence is t[m-1-k], matched at right[m-1-k].
            // This is valid as long as left[0] < right[m-1-k], which holds if t is a subsequence of s.
            minScore = Math.min(minScore, right[m-1-k] - left[0] + 1);
        }

        return minScore;
    }
}