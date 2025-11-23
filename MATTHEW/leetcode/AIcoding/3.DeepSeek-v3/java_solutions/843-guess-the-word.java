class Solution {
    public void findSecretWord(String[] wordlist, Master master) {
        Random random = new Random();
        for (int i = 0, matches = 0; i < 10 && matches < 6; i++) {
            String guess = wordlist[random.nextInt(wordlist.length)];
            matches = master.guess(guess);
            List<String> candidates = new ArrayList<>();
            for (String word : wordlist) {
                if (matches == getMatches(guess, word)) {
                    candidates.add(word);
                }
            }
            wordlist = candidates.toArray(new String[0]);
        }
    }

    private int getMatches(String a, String b) {
        int matches = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) == b.charAt(i)) {
                matches++;
            }
        }
        return matches;
    }
}