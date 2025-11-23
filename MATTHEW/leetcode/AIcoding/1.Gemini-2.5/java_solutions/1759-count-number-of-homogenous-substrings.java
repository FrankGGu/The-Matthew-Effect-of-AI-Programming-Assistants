class Solution {
    public int countHomogenous(String s) {
        long totalCount = 0;
        int MOD = 1_000_000_007;
        int currentConsecutiveLength = 0;

        for (int i = 0; i < s.length(); i++) {
            if (i == 0 || s.charAt(i) == s.charAt(i - 1)) {
                currentConsecutiveLength++;
            } else {
                currentConsecutiveLength = 1;
            }
            totalCount = (totalCount + currentConsecutiveLength) % MOD;
        }

        return (int) totalCount;
    }
}