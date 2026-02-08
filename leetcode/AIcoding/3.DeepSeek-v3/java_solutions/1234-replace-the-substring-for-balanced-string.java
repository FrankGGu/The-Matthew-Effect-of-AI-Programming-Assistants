class Solution {
    public int balancedString(String s) {
        int[] count = new int[128];
        int n = s.length();
        int res = n;
        int left = 0;

        for (int i = 0; i < n; i++) {
            count[s.charAt(i)]++;
        }

        for (int right = 0; right < n; right++) {
            count[s.charAt(right)]--;
            while (left < n && count['Q'] <= n / 4 && count['W'] <= n / 4 && count['E'] <= n / 4 && count['R'] <= n / 4) {
                res = Math.min(res, right - left + 1);
                count[s.charAt(left)]++;
                left++;
            }
        }

        return res;
    }
}