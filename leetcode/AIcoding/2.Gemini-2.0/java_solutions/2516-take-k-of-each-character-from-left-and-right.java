class Solution {
    public int takeCharacters(String s, int k) {
        int n = s.length();
        int[] count = new int[3];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        if (count[0] < k || count[1] < k || count[2] < k) {
            return -1;
        }
        int left = 0;
        int right = n;
        int ans = n;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(s, k, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }

    private boolean check(String s, int k, int len) {
        int n = s.length();
        for (int i = 0; i <= len; i++) {
            int left = i;
            int right = n - (len - i);

            int[] count = new int[3];
            for (int j = 0; j < left; j++) {
                count[s.charAt(j) - 'a']++;
            }
            for (int j = right; j < n; j++) {
                count[s.charAt(j) - 'a']++;
            }

            if (count[0] >= k && count[1] >= k && count[2] >= k) {
                return true;
            }
        }
        return false;
    }
}