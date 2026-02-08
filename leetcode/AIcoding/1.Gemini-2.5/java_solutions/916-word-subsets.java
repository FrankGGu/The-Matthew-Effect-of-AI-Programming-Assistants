import java.util.ArrayList;
import java.util.List;

class Solution {

    private int[] countChars(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        return freq;
    }

    public List<String> wordSubsets(String[] words1, String[] words2) {
        int[] maxFreqB = new int[26];

        for (String b : words2) {
            int[] currentFreqB = countChars(b);
            for (int i = 0; i < 26; i++) {
                maxFreqB[i] = Math.max(maxFreqB[i], currentFreqB[i]);
            }
        }

        List<String> result = new ArrayList<>();

        for (String a : words1) {
            int[] freqA = countChars(a);
            boolean isUniversal = true;
            for (int i = 0; i < 26; i++) {
                if (freqA[i] < maxFreqB[i]) {
                    isUniversal = false;
                    break;
                }
            }
            if (isUniversal) {
                result.add(a);
            }
        }

        return result;
    }
}