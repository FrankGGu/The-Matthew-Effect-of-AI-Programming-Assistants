class Solution {
    public long countSubstrings(String s) {
        long ans = 0;
        int lastA = -1;
        int lastB = -1;
        int lastC = -1;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == 'a') {
                lastA = i;
            } else if (c == 'b') {
                lastB = i;
            } else if (c == 'c') {
                lastC = i;
            }

            // For a substring ending at index 'i' to be "good",
            // it must contain at least one 'a', one 'b', and one 'c'.
            // This means its starting index 'j' must be less than or equal to
            // the most recent occurrences of 'a', 'b', and 'c'.
            // So, j <= lastA, j <= lastB, and j <= lastC.
            // This implies j <= min(lastA, lastB, lastC).
            // The number of such valid 'j's is min(lastA, lastB, lastC) + 1.
            // We use Math.max(0, ...) to handle cases where not all 'a', 'b', 'c'
            // have appeared yet (i.e., one of lastA, lastB, lastC is -1).
            ans += Math.max(0, Math.min(lastA, Math.min(lastB, lastC)) + 1);
        }

        return ans;
    }
}