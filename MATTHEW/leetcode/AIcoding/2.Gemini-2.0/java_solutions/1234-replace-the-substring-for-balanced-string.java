class Solution {
    public int balancedString(String s) {
        int n = s.length();
        int k = n / 4;
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'A']++;
        }

        int left = 0, right = 0, minLen = n;
        while (right < n) {
            count[s.charAt(right) - 'A']--;
            while (left <= right && count['Q' - 'A'] <= k && count['W' - 'A'] <= k &&
                   count['E' - 'A'] <= k && count['R' - 'A'] <= k) {
                minLen = Math.min(minLen, right - left + 1);
                count[s.charAt(left) - 'A']++;
                left++;
            }
            right++;
        }
        return minLen;
    }
}