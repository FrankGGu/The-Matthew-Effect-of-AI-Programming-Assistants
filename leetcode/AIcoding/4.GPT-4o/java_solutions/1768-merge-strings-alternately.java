class Solution {
    public String mergeAlternately(String word1, String word2) {
        StringBuilder result = new StringBuilder();
        int i = 0, n1 = word1.length(), n2 = word2.length();

        while (i < n1 || i < n2) {
            if (i < n1) result.append(word1.charAt(i));
            if (i < n2) result.append(word2.charAt(i));
            i++;
        }

        return result.toString();
    }
}