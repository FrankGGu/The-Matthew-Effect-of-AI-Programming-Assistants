class Solution {
    public int minimumPartition(String s, int k) {
        int res = 0;
        long current = 0;
        for (int i = 0; i < s.length(); i++) {
            int digit = s.charAt(i) - '0';
            if (digit > k) {
                return -1;
            }
            current = current * 10 + digit;
            if (current > k) {
                res++;
                current = digit;
            }
        }
        return res + 1;
    }
}