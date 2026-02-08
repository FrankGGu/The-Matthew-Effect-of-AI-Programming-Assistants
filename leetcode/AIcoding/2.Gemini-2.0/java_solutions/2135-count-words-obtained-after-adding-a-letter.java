import java.util.HashSet;
import java.util.Set;

class Solution {
    public int wordCount(String[] startWords, String[] targetWords) {
        Set<String> startWordSignatures = new HashSet<>();
        for (String word : startWords) {
            char[] chars = word.toCharArray();
            java.util.Arrays.sort(chars);
            startWordSignatures.add(new String(chars));
        }

        int count = 0;
        for (String targetWord : targetWords) {
            char[] targetChars = targetWord.toCharArray();
            java.util.Arrays.sort(targetChars);
            String sortedTargetWord = new String(targetChars);

            for (int i = 0; i < sortedTargetWord.length(); i++) {
                String possibleStartWord = sortedTargetWord.substring(0, i) + sortedTargetWord.substring(i + 1);
                if (startWordSignatures.contains(possibleStartWord)) {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
}