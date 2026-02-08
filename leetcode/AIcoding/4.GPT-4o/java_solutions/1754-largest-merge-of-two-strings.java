class Solution {
    public String largestMerge(String word1, String word2) {
        StringBuilder result = new StringBuilder();
        int i = 0, j = 0;

        while (i < word1.length() && j < word2.length()) {
            if (word1.compareTo(word2) > 0) {
                result.append(word1.charAt(i++));
            } else {
                result.append(word2.charAt(j++));
            }
        }

        result.append(word1.substring(i));
        result.append(word2.substring(j));

        return result.toString();
    }
}