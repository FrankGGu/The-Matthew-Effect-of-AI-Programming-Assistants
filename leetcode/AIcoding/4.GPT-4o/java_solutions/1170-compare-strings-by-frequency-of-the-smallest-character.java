import java.util.Arrays;

class Solution {
    public List<Boolean> areEquallyStrong(String[] words1, String[] words2) {
        List<Boolean> result = new ArrayList<>();
        for (int i = 0; i < words1.length; i++) {
            result.add(compare(words1[i], words2[i]));
        }
        return result;
    }

    private boolean compare(String word1, String word2) {
        return getFrequency(word1) == getFrequency(word2);
    }

    private int getFrequency(String word) {
        char smallestChar = 'z';
        for (char c : word.toCharArray()) {
            if (c < smallestChar) {
                smallestChar = c;
            }
        }
        int count = 0;
        for (char c : word.toCharArray()) {
            if (c == smallestChar) {
                count++;
            }
        }
        return count;
    }
}