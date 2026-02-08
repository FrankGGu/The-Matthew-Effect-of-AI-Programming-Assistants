class Solution {
    public String longestDupSubstring(String s) {
        int n = s.length();
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = s.charAt(i) - 'a';
        }

        int left = 1, right = n;
        int len = 0, start = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int pos = rabinKarp(nums, mid);
            if (pos != -1) {
                len = mid;
                start = pos;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return start != -1 ? s.substring(start, start + len) : "";
    }

    private int rabinKarp(int[] nums, int len) {
        int n = nums.length;
        long h = 0;
        long q = (long) (1e9 + 7);
        long pow = 1;
        int a = 26;

        for (int i = 0; i < len; i++) {
            h = (h * a + nums[i]) % q;
            if (i < len - 1) pow = (pow * a) % q;
        }

        HashSet<Long> seen = new HashSet<>();
        seen.add(h);

        for (int i = 1; i <= n - len; i++) {
            h = (h * a - nums[i - 1] * pow % q + q) % q;
            h = (h + nums[i + len - 1]) % q;

            if (seen.contains(h)) {
                return i;
            }
            seen.add(h);
        }

        return -1;
    }
}