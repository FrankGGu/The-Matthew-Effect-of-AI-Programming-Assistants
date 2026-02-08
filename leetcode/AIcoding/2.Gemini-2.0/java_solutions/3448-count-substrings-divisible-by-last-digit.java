class Solution {
    public long countSubstrings(String s) {
        int n = s.length();
        long ans = 0;
        for (int i = 0; i < n; i++) {
            int lastDigit = s.charAt(i) - '0';
            if (lastDigit != 0 && lastDigit % 2 == 0) {
                ans++;
            }
            if (lastDigit == 5) {
                ans++;
            }
        }
        return ans;
    }
}