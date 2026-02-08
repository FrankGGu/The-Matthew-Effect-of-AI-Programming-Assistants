class Solution {
    public int minimumScore(String s, String t) {
        int n = s.length();
        int m = t.length();
        int[] prefix = new int[m + 1];
        int[] suffix = new int[m + 1];
        prefix[0] = -1;
        suffix[m] = n;

        int j = 0;
        for (int i = 0; i < n && j < m; i++) {
            if (s.charAt(i) == t.charAt(j)) {
                prefix[++j] = i;
            }
        }

        j = m - 1;
        for (int i = n - 1; i >= 0 && j >= 0; i--) {
            if (s.charAt(i) == t.charAt(j)) {
                suffix[j--] = i;
            }
        }

        int ans = m;
        for (int i = 0; i <= m; i++) {
            int left = i;
            int right = m;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (prefix[i] < suffix[mid]) {
                    ans = Math.min(ans, mid - i);
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
        }

        return ans;
    }
}