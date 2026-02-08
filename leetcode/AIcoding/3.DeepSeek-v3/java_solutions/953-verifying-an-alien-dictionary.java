class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        int[] orderMap = new int[26];
        for (int i = 0; i < order.length(); i++) {
            orderMap[order.charAt(i) - 'a'] = i;
        }

        for (int i = 0; i < words.length - 1; i++) {
            if (!compare(words[i], words[i + 1], orderMap)) {
                return false;
            }
        }
        return true;
    }

    private boolean compare(String word1, String word2, int[] orderMap) {
        int len1 = word1.length();
        int len2 = word2.length();
        int minLen = Math.min(len1, len2);
        for (int i = 0; i < minLen; i++) {
            char c1 = word1.charAt(i);
            char c2 = word2.charAt(i);
            if (orderMap[c1 - 'a'] < orderMap[c2 - 'a']) {
                return true;
            } else if (orderMap[c1 - 'a'] > orderMap[c2 - 'a']) {
                return false;
            }
        }
        return len1 <= len2;
    }
}