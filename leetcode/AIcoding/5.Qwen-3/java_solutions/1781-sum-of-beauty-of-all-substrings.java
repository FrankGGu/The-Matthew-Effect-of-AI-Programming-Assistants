public class Solution {
    public int beautySum(String s) {
        int result = 0;
        for (int i = 0; i < s.length(); i++) {
            int[] count = new int[26];
            for (int j = i; j < s.length(); j++) {
                count[s.charAt(j) - 'a']++;
                int maxFreq = 0;
                int minFreq = Integer.MAX_VALUE;
                for (int k = 0; k < 26; k++) {
                    if (count[k] > 0) {
                        maxFreq = Math.max(maxFreq, count[k]);
                        minFreq = Math.min(minFreq, count[k]);
                    }
                }
                result += maxFreq - minFreq;
            }
        }
        return result;
    }
}