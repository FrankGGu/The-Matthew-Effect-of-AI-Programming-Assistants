class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();

        // dp0[i] represents the minimum flips to make s[0...i] all '0's.
        // dp1[i] represents the minimum flips to make s[0...i] monotone increasing, ending with '1'.

        // Base cases for an empty prefix (before the first character)
        // If we have an empty string, 0 flips are needed to make it all '0's or all '1's.
        int dp0 = 0; 
        int dp1 = 0; 

        for (int i = 0; i < n; i++) {
            char currentChar = s.charAt(i);

            int next_dp0;
            int next_dp1;

            if (currentChar == '0') {
                // To make s[0...i] all '0's:
                // If s[i] is '0', no flip needed. Cost is same as dp0 for s[0...i-1].
                next_dp0 = dp0;

                // To make s[0...i] monotone increasing ending with '1':
                // s[i] must be flipped to '1'. Cost +1.
                // The prefix s[0...i-1] could have been all '0's (dp0) or monotone ending in '1' (dp1).
                // We take the minimum of these two options.
                next_dp1 = Math.min(dp0, dp1) + 1;
            } else { // currentChar == '1'
                // To make s[0...i] all '0's:
                // s[i] must be flipped to '0'. Cost +1.
                next_dp0 = dp0 + 1;

                // To make s[0...i] monotone increasing ending with '1':
                // If s[i] is '1', no flip needed. Cost is same as min of dp0/dp1 for s[0...i-1].
                // The prefix s[0...i-1] could have been all '0's (dp0) or monotone ending in '1' (dp1).
                next_dp1 = Math.min(dp0, dp1);
            }

            dp0 = next_dp0;
            dp1 = next_dp1;
        }

        // The final answer is the minimum of making the entire string all '0's (dp0)
        // or making it monotone increasing ending in '1' (dp1).
        return Math.min(dp0, dp1);
    }
}