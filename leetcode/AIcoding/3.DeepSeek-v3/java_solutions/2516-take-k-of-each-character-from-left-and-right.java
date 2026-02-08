class Solution {
    public int takeCharacters(String s, int k) {
        int n = s.length();
        int[] freq = new int[3];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        if (freq[0] < k || freq[1] < k || freq[2] < k) {
            return -1;
        }
        int left = 0;
        int maxWindow = 0;
        int[] windowCount = new int[3];
        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            windowCount[c - 'a']++;
            while (windowCount[c - 'a'] > freq[c - 'a'] - k) {
                windowCount[s.charAt(left) - 'a']--;
                left++;
            }
            maxWindow = Math.max(maxWindow, right - left + 1);
        }
        return n - maxWindow;
    }
}