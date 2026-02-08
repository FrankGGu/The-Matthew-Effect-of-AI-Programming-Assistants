public class Solution {

import java.util.*;

class Solution {
    public void findWord(String[] wordList, int[] guessResult) {
        List<String> possible = new ArrayList<>(Arrays.asList(wordList));
        Random rand = new Random();
        for (int i = 0; i < 10; i++) {
            String candidate = possible.get(rand.nextInt(possible.size()));
            int match = match(candidate, guessResult);
            if (match == 6) {
                return;
            }
            List<String> next = new ArrayList<>();
            for (String word : possible) {
                if (match(word, candidate) == match) {
                    next.add(word);
                }
            }
            possible = next;
        }
    }

    private int match(String a, String b) {
        int res = 0;
        for (int i = 0; i < 6; i++) {
            if (a.charAt(i) == b.charAt(i)) {
                res++;
            }
        }
        return res;
    }
}
}