class Solution {
    public int countInfectionSequences(String s) {
        int n = s.length();
        long mod = 1_000_000_007;
        long count = 0;
        long result = 1;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'I') {
                count++;
            } else {
                if (count > 0) {
                    result = (result * (count + 1)) % mod;
                }
                count = 0;
            }
        }

        if (count > 0) {
            result = (result * (count + 1)) % mod;
        }

        return (int) result;
    }
}