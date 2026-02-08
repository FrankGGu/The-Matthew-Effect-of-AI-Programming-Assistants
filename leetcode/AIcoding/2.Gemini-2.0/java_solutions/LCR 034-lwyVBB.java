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
            int j = 0;
            while (j < len1 && j < len2) {
                int char1 = word1.charAt(j) - 'a';
                int char2 = word2.charAt(j) - 'a';
                if (orderMap[char1] < orderMap[char2]) {
                    break;
                } else if (orderMap[char1] > orderMap[char2]) {
                    return false;
                }
                j++;
            }
            if (j == len2 && j < len1) {
                return false;
            }
        }
        return true;
    }
}