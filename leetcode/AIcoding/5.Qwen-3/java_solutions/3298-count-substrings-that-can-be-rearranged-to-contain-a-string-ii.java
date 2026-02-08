public class Solution {
    public int countPossibleSubstrings(String s, String t) {
        int[] freq = new int[26];
        int n = t.length();
        for (int i = 0; i < n; i++) {
            freq[t.charAt(i) - 'a']++;
        }

        int result = 0;
        int[] window = new int[26];
        int left = 0;

        for (int right = 0; right < s.length(); right++) {
            window[s.charAt(right) - 'a']++;

            while (window[s.charAt(right) - 'a'] > freq[s.charAt(right) - 'a']) {
                window[s.charAt(left) - 'a']--;
                left++;
            }

            boolean valid = true;
            for (int i = 0; i < 26; i++) {
                if (window[i] > freq[i]) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                result++;
            }
        }

        return result;
    }
}