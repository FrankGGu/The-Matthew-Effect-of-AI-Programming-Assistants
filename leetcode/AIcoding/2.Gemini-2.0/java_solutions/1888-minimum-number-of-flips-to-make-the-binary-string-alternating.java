class Solution {
    public int minFlips(String s) {
        int n = s.length();
        String s2 = s + s;
        int[] odd = new int[2];
        int[] even = new int[2];
        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < 2 * n; i++) {
            int num = s2.charAt(i) - '0';
            if (i % 2 == 0) {
                even[num]++;
            } else {
                odd[num]++;
            }
            if (i >= n) {
                int num2 = s2.charAt(i - n) - '0';
                if ((i - n) % 2 == 0) {
                    even[num2]--;
                } else {
                    odd[num2]--;
                }
            }
            if (i >= n - 1) {
                ans = Math.min(ans, (n - even[0]) + (n - odd[1]));
                ans = Math.min(ans, (n - even[1]) + (n - odd[0]));
            }
        }
        return ans;
    }
}