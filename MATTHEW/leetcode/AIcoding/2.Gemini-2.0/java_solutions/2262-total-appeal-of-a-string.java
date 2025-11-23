class Solution {
    public long appealSum(String s) {
        long res = 0;
        int n = s.length();
        int[] last = new int[26];
        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            res += (long) (i - last[c]) * (n - i);
            last[c] = i;
        }
        return res;
    }
}