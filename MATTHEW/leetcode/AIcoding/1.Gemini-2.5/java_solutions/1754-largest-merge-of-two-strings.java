class Solution {
    public String largestMerge(String word1, String word2) {
        StringBuilder sb = new StringBuilder();
        int i = 0;
        int j = 0;

        while (i < word1.length() || j < word2.length()) {
            if (i < word1.length() && j < word2.length()) {
                if (word1.charAt(i) > word2.charAt(j)) {
                    sb.append(word1.charAt(i));
                    i++;
                } else if (word2.charAt(j) > word1.charAt(i)) {
                    sb.append(word2.charAt(j));
                    j++;
                } else { // word1.charAt(i) == word2.charAt(j)
                    // If characters are equal, compare the remaining suffixes
                    // Take from word1 if its suffix is lexicographically greater
                    // Otherwise, take from word2
                    if (word1.substring(i).compareTo(word2.substring(j)) > 0) {
                        sb.append(word1.charAt(i));
                        i++;
                    } else {
                        sb.append(word2.charAt(j));
                        j++;
                    }
                }
            } else if (i < word1.length()) { // Only word1 has remaining characters
                sb.append(word1.charAt(i));
                i++;
            } else { // Only word2 has remaining characters
                sb.append(word2.charAt(j));
                j++;
            }
        }

        return sb.toString();
    }
}