class MagicDictionary {

    private String[] dict;

    public MagicDictionary() {

    }

    public void buildDict(String[] dictionary) {
        dict = dictionary;
    }

    public boolean search(String searchWord) {
        for (String word : dict) {
            if (word.length() != searchWord.length()) {
                continue;
            }
            int diff = 0;
            for (int i = 0; i < word.length(); i++) {
                if (word.charAt(i) != searchWord.charAt(i)) {
                    diff++;
                }
            }
            if (diff == 1) {
                return true;
            }
        }
        return false;
    }
}