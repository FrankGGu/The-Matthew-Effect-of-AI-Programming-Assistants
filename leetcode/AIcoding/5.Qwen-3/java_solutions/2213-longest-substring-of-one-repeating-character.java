public class Solution {
    public int longestRepeatingSubstring(String s) {
        int n = s.length();
        int left = 0, right = n - 1;
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(s, mid)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }

    private boolean check(String s, int k) {
        int n = s.length();
        int[] hash = new int[256];
        for (int i = 0; i < k; i++) {
            hash[s.charAt(i)]++;
        }
        if (maxCount(hash) >= k) return true;

        for (int i = k; i < n; i++) {
            hash[s.charAt(i - k)]--;
            hash[s.charAt(i)]++;
            if (maxCount(hash) >= k) return true;
        }

        return false;
    }

    private int maxCount(int[] hash) {
        int max = 0;
        for (int count : hash) {
            if (count > max) {
                max = count;
            }
        }
        return max;
    }
}