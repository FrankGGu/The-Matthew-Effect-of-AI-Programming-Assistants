class Solution {
    public int countHomogenous(String s) {
        final int MOD = 1000000007;
        long result = 0;
        int currentLength = 1;

        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                currentLength++;
            } else {
                result = (result + (long) currentLength * (currentLength + 1) / 2) % MOD;
                currentLength = 1;
            }
        }
        result = (result + (long) currentLength * (currentLength + 1) / 2) % MOD;

        return (int) result;
    }
}