import java.util.Random;

public class Solution {
    public void findSecretWord(String[] words, Master master) {
        Random rand = new Random();
        int n = words.length;

        for (int i = 0; i < 10; i++) {
            String guess = words[rand.nextInt(n)];
            int match = master.guess(guess);
            if (match == 6) return;
            words = filterWords(words, guess, match);
            n = words.length;
        }
    }

    private String[] filterWords(String[] words, String guess, int match) {
        return Arrays.stream(words)
            .filter(word -> getMatchCount(word, guess) == match)
            .toArray(String[]::new);
    }

    private int getMatchCount(String a, String b) {
        int count = 0;
        for (int i = 0; i < 6; i++) {
            if (a.charAt(i) == b.charAt(i)) count++;
        }
        return count;
    }
}