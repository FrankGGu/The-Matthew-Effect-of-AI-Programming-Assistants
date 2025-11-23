class Solution {
    public String longestWord(String[] words) {
        String longest = "";
        java.util.Set<String> set = new java.util.HashSet<>();
        for (String word : words) {
            set.add(word);
        }
        for (String word : words) {
            boolean valid = true;
            for (int i = 1; i < word.length(); i++) {
                if (!set.contains(word.substring(0, i))) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                if (word.length() > longest.length()) {
                    longest = word;
                } else if (word.length() == longest.length() && word.compareTo(longest) < 0) {
                    longest = word;
                }
            }
        }
        return longest;
    }
}