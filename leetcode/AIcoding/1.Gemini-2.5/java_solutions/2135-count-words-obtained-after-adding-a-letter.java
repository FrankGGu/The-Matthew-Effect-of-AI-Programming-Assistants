import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int wordCount(String[] startWords, String[] targetWords) {
        Set<String> startWordSortedSet = new HashSet<>();

        for (String startWord : startWords) {
            char[] chars = startWord.toCharArray();
            Arrays.sort(chars);
            startWordSortedSet.add(new String(chars));
        }

        int count = 0;
        for (String targetWord : targetWords) {
            char[] targetChars = targetWord.toCharArray();
            Arrays.sort(targetChars);

            for (int i = 0; i < targetChars.length; i++) {
                char[] candidateChars = new char[targetChars.length - 1];

                System.arraycopy(targetChars, 0, candidateChars, 0, i);
                System.arraycopy(targetChars, i + 1, candidateChars, i, targetChars.length - 1 - i);

                String candidateStartWord = new String(candidateChars);

                if (startWordSortedSet.contains(candidateStartWord)) {
                    count++;
                    break; 
                }
            }
        }

        return count;
    }
}