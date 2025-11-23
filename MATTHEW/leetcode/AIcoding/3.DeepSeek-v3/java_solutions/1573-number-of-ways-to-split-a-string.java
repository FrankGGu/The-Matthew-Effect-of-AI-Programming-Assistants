class Solution {
    public int numWays(String s) {
        int mod = 1_000_000_007;
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                count++;
            }
        }
        if (count % 3 != 0) {
            return 0;
        }
        if (count == 0) {
            long n = s.length();
            return (int) (((n - 1) * (n - 2) / 2) % mod);
        }
        int target = count / 3;
        int firstEnd = 0;
        int secondEnd = 0;
        int current = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                current++;
            }
            if (current == target) {
                firstEnd++;
            } else if (current == 2 * target) {
                secondEnd++;
            }
        }
        return (int) ((long) firstEnd * secondEnd % mod);
    }
}