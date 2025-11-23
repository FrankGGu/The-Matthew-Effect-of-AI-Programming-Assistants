public class Solution {
    public int countHomogenous(String s) {
        int count = 0;
        int MOD = 1000000007;
        int n = s.length();
        for (int i = 0; i < n; ) {
            char c = s.charAt(i);
            int j = i;
            while (j < n && s.charAt(j) == c) {
                j++;
            }
            long len = j - i;
            count = (count + (int)(len * (len + 1) / 2)) % MOD;
            i = j;
        }
        return count;
    }
}