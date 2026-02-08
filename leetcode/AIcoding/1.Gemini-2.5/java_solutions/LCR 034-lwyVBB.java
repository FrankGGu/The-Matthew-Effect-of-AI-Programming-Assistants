class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        int[] charOrder = new int[26];
        for (int i = 0; i < order.length(); i++) {
            charOrder[order.charAt(i) - 'a'] = i;
        }

        for (int i = 0; i < words.length - 1; i++) {
            String word1 = words[i];
            String word2 = words[i + 1];

            int j = 0;
            while (j < word1.length() && j < word2.length()) {
                char c1 = word1.charAt(j);
                char c2 = word2.charAt(j);

                if (charOrder[c1 - 'a'] < charOrder[c2 - 'a']) {
                    break; // word1 is smaller, correctly ordered
                } else if (charOrder[c1 - 'a'] > charOrder[c2 - 'a']) {
                    return false; // word1 is larger, not sorted
                }
                // If characters are equal, continue to the next character
                j++;
            }

            // If we reached the end of word2, and word1 is longer, it's not sorted
            if (j == word2.length() && word1.length() > word2.length()) {
                return false;
            }
        }

        return true;
    }
}