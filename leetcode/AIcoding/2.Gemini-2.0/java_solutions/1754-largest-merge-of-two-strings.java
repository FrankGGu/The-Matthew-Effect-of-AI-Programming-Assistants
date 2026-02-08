class Solution {
    public String largestMerge(String word1, String word2) {
        StringBuilder sb = new StringBuilder();
        int i = 0, j = 0;
        while (i < word1.length() || j < word2.length()) {
            if (i < word1.length() && j < word2.length()) {
                if (word1.substring(i).compareTo(word2.substring(j)) > 0) {
                    sb.append(word1.charAt(i++));
                } else {
                    sb.append(word2.charAt(j++));
                }
            } else if (i < word1.length()) {
                sb.append(word1.charAt(i++));
            } else {
                sb.append(word2.charAt(j++));
            }
        }
        return sb.toString();
    }
}