class Solution {
    public int minimumTime(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];

        // Calculate minimum cost to remove all '1's in s[0...i]
        // left[i] represents the minimum cost to clear all '1's in the prefix s[0...i]
        // If s[i] is '0', no additional cost is incurred for s[i].
        // If s[i] is '1', we have two options:
        // 1. Extend the removal from s[i-1]: cost is left[i-1] + 1.
        // 2. Remove the entire prefix s[0...i] from the left: cost is i+1.
        // We take the minimum of these two options.
        left[0] = (s.charAt(0) == '1' ? 1 : 0);
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) == '0') {
                left[i] = left[i - 1];
            } else {
                left[i] = Math.min(left[i - 1] + 1, i + 1);
            }
        }

        // Calculate minimum cost to remove all '1's in s[i...n-1]
        // right[i] represents the minimum cost to clear all '1's in the suffix s[i...n-1]
        // Similar logic to left array, but from right to left.
        right[n - 1] = (s.charAt(n - 1) == '1' ? 1 : 0);
        for (int i = n - 2; i >= 0; i--) {
            if (s.charAt(i) == '0') {
                right[i] = right[i + 1];
            } else {
                right[i] = Math.min(right[i + 1] + 1, n - i);
            }
        }

        // The total minimum cost is the minimum of:
        // 1. Clearing all '1's using only left operations (left[n-1]).
        // 2. Clearing all '1's using only right operations (right[0]).
        // 3. Clearing '1's in s[0...i] using left operations and '1's in s[i+1...n-1] using right operations.
        int minCost = Math.min(left[n - 1], right[0]);

        for (int i = 0; i < n - 1; i++) {
            minCost = Math.min(minCost, left[i] + right[i + 1]);
        }

        return minCost;
    }
}