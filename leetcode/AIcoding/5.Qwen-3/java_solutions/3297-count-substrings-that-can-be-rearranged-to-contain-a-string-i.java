public class Solution {
    public int countPossibleSubstrings(String s) {
        int[] freq = new int[26];
        int result = 0;
        for (int i = 0; i < s.length(); i++) {
            freq[s.charAt(i) - 'a']++;
            boolean valid = true;
            for (int j = 0; j < 26; j++) {
                if (freq[j] > 0 && freq[j] % 2 != 0) {
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