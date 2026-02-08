class Solution {
    public int numSub(String s) {
        long ans = 0;
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                count++;
            } else {
                ans += (long)count * (count + 1) / 2;
                ans %= 1000000007;
                count = 0;
            }
        }
        ans += (long)count * (count + 1) / 2;
        ans %= 1000000007;
        return (int)ans;
    }
}