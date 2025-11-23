class Solution {
    public int minFlips(String s) {
        int n = s.length();
        String target1 = "", target2 = "";
        for (int i = 0; i < n; i++) {
            target1 += (i % 2 == 0) ? '0' : '1';
            target2 += (i % 2 == 0) ? '1' : '0';
        }

        int res1 = 0, res2 = 0;
        int res = Integer.MAX_VALUE;
        for (int i = 0; i < 2 * n; i++) {
            char c = s.charAt(i % n);
            if (c != target1.charAt(i % n)) res1++;
            if (c != target2.charAt(i % n)) res2++;

            if (i >= n) {
                char prev = s.charAt((i - n) % n);
                if (prev != target1.charAt((i - n) % n)) res1--;
                if (prev != target2.charAt((i - n) % n)) res2--;
            }

            if (i >= n - 1) {
                res = Math.min(res, Math.min(res1, res2));
            }
        }
        return res;
    }
}