class Solution {
    public int countHomogenous(String s) {
        long count = 0, total = 0;
        int mod = 1000000007;

        for (int i = 0; i < s.length(); i++) {
            count = (s.charAt(i) == s.charAt(i - 1)) ? count + 1 : 1;
            total = (total + count) % mod;
        }

        return (int) total;
    }
}