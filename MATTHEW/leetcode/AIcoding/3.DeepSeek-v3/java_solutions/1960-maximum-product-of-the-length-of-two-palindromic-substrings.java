class Solution {
    public long maxProduct(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];

        int maxRight = 0, center = 0;
        for (int i = 0; i < n; i++) {
            if (i < maxRight) {
                left[i] = Math.min(left[2 * center - i], maxRight - i);
            }
            int l = i - left[i], r = i + left[i];
            while (l - 1 >= 0 && r + 1 < n && s.charAt(l - 1) == s.charAt(r + 1)) {
                left[i]++;
                l--;
                r++;
            }
            if (r > maxRight) {
                maxRight = r;
                center = i;
            }
        }

        maxRight = 0; center = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (i > maxRight) {
                right[i] = Math.min(right[2 * center - i], i - maxRight);
            }
            int l = i - right[i], r = i + right[i];
            while (l - 1 >= 0 && r + 1 < n && s.charAt(l - 1) == s.charAt(r + 1)) {
                right[i]++;
                l--;
                r++;
            }
            if (l < maxRight) {
                maxRight = l;
                center = i;
            }
        }

        int[] prefix = new int[n];
        int[] suffix = new int[n];
        prefix[0] = 1;
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1];
            if (2 * left[i] + 1 > 2 * prefix[i] - 1) {
                prefix[i] = left[i] + 1;
            }
        }

        suffix[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            suffix[i] = suffix[i + 1];
            if (2 * right[i] + 1 > 2 * suffix[i] - 1) {
                suffix[i] = right[i] + 1;
            }
        }

        long res = 0;
        for (int i = 0; i < n - 1; i++) {
            res = Math.max(res, (long) (2 * prefix[i] - 1) * (2 * suffix[i + 1] - 1));
        }

        return res;
    }
}