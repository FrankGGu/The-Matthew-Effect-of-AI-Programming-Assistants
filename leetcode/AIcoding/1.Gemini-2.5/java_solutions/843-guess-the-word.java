class Solution {
    public void findSecretWord(String[] wordlist, Master master) {
        List<String> possibleWords = new ArrayList<>(Arrays.asList(wordlist));
        Random rand = new Random();

        for (int i = 0; i < 10 && !possibleWords.isEmpty(); i++) {
            String guessWord = possibleWords.get(rand.nextInt(possibleWords.size()));

            int matches = master.guess(guessWord);

            if (matches == 6) {
                return;
            }

            List<String> nextPossibleWords = new ArrayList<>();
            for (String word : possibleWords) {
                if (countMatches(guessWord, word) == matches) {
                    nextPossibleWords.add(word);
                }
            }
            possibleWords = nextPossibleWords;
        }
    }

    private int countMatches(String s1, String s2) {
        int matches = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) == s2.charAt(i)) {
                matches++;
            }
        }
        return matches;
    }
}