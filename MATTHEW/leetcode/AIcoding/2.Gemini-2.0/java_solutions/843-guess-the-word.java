import java.util.Random;

class Solution {
    public void findSecretWord(String[] wordlist, Master master) {
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            int index = random.nextInt(wordlist.length);
            String guessWord = wordlist[index];
            int match = master.guess(guessWord);
            if (match == 6) {
                return;
            }
            String[] newList = new String[wordlist.length];
            int newSize = 0;
            for (String word : wordlist) {
                if (matches(guessWord, word) == match) {
                    newList[newSize++] = word;
                }
            }
            wordlist = new String[newSize];
            System.arraycopy(newList, 0, wordlist, 0, newSize);
        }
    }

    private int matches(String word1, String word2) {
        int match = 0;
        for (int i = 0; i < word1.length(); i++) {
            if (word1.charAt(i) == word2.charAt(i)) {
                match++;
            }
        }
        return match;
    }
}