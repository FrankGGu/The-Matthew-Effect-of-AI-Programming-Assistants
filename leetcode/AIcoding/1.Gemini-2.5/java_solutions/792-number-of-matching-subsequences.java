import java.util.ArrayList;
import java.util.List;

class Solution {
    public int numMatchingSubsequences(String s, String[] words) {
        List<int[]>[] waiting = new List[26];
        for (int i = 0; i < 26; i++) {
            waiting[i] = new ArrayList<>();
        }

        for (int i = 0; i < words.length; i++) {
            waiting[words[i].charAt(0) - 'a'].add(new int[]{i, 0});
        }

        int count = 0;

        for (char c : s.toCharArray()) {
            List<int[]> currentWaiting = waiting[c - 'a'];
            waiting[c - 'a'] = new ArrayList<>(); 

            for (int[] pair : currentWaiting) {
                int wordOriginalIndex = pair[0];
                int charIndexInWord = pair[1];

                charIndexInWord++;

                if (charIndexInWord == words[wordOriginalIndex].length()) {
                    count++;
                } else {
                    char nextChar = words[wordOriginalIndex].charAt(charIndexInWord);
                    waiting[nextChar - 'a'].add(new int[]{wordOriginalIndex, charIndexInWord});
                }
            }
        }

        return count;
    }
}