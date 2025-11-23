class Solution {
    public int minimumScore(String s, String t) {
        int m = s.length(), n = t.length();
        int[] left = new int[n];
        Arrays.fill(left, -1);
        int i = 0, j = 0;
        while (i < m && j < n) {
            if (s.charAt(i) == t.charAt(j)) {
                left[j] = i;
                j++;
            }
            i++;
        }
        int[] right = new int[n];
        Arrays.fill(right, -1);
        i = m - 1;
        j = n - 1;
        while (i >= 0 && j >= 0) {
            if (s.charAt(i) == t.charAt(j)) {
                right[j] = i;
                j--;
            }
            i--;
        }
        if (j < 0) {
            return 0;
        }
        int res = n;
        for (int k = -1; k < n; k++) {
            int l = k == -1 ? -1 : left[k];
            int r = (k + 1) < n ? right[k + 1] : m;
            if (l != -1 || r != m) {
                res = Math.min(res, (n - (k + 1) - (n - (k + 1 - 0))));
            }
        }
        return res;
    }
}