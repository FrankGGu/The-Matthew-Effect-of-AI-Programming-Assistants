class Solution {
    public int numWays(String s) {
        int n = s.length();
        int mod = 1000000007;
        int ones = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                ones++;
            }
        }

        if (ones % 3 != 0) {
            return 0;
        }

        if (ones == 0) {
            return (int) (((long) (n - 1) * (n - 2) / 2) % mod);
        }

        int target = ones / 3;
        long count1 = 0;
        long count2 = 0;
        int current = 0;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                current++;
            }
            if (current == target) {
                count1++;
            } else if (current == 2 * target) {
                count2++;
            }
        }

        return (int) ((count1 * count2) % mod);
    }
}