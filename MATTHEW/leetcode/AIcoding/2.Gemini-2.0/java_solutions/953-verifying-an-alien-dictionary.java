class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        int[] orderMap = new int[26];
        for (int i = 0; i < order.length(); i++) {
            orderMap[order.charAt(i) - 'a'] = i;
        }

        for (int i = 0; i < words.length - 1; i++) {
            String word1 = words[i];
            String word2 = words[i + 1];
            int len1 = word1.length();
            int len2 = word2.length();
            int minLen = Math.min(len1, len2);

            boolean found = false;
            for (int j = 0; j < minLen; j++) {
                char char1 = word1.charAt(j);
                char char2 = word2.charAt(j);
                if (orderMap[char1 - 'a'] < orderMap[char2 - 'a']) {
                    found = true;
                    break;
                } else if (orderMap[char1 - 'a'] > orderMap[char2 - 'a']) {
                    return false;
                }
            }

            if (!found && len1 > len2) {
                return false;
            }
        }

        return true;
    }
}