class Solution {
    public String longestWord(String[] words) {
        Arrays.sort(words);
        Set<String> built = new HashSet<>();
        String res = "";
        for (String word : words) {
            if (word.length() == 1 || built.contains(word.substring(0, word.length() - 1))) {
                if (word.length() > res.length()) {
                    res = word;
                }
                built.add(word);
            }
        }
        return res;
    }
}