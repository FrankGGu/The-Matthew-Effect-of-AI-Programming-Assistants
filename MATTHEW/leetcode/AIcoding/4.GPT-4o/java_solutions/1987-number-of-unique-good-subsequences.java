class Solution {
    public int countGoodSubsequences(String binary) {
        int n = binary.length();
        long mod = 1000000007;
        long count = 0;
        boolean hasOne = false;
        long lastOne = 0;

        for (int i = 0; i < n; i++) {
            if (binary.charAt(i) == '1') {
                hasOne = true;
                lastOne = (lastOne * 2 + 1) % mod;
            } else {
                lastOne = (lastOne * 2) % mod;
            }
        }

        if (hasOne) {
            count = (lastOne + 1) % mod;
        }

        return (int) count;
    }
}