class Solution {
    public int countHomogenous(String s) {
        long count = 0;
        int mod = 1000000007;
        int i = 0;
        while (i < s.length()) {
            int j = i;
            while (j < s.length() && s.charAt(i) == s.charAt(j)) {
                j++;
            }
            long len = j - i;
            count = (count + (len * (len + 1)) / 2) % mod;
            i = j;
        }
        return (int) count;
    }
}