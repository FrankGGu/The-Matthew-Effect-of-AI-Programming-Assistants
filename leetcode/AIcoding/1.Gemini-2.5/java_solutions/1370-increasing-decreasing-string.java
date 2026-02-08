class Solution {
    public String sortString(String s) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        StringBuilder result = new StringBuilder();
        int totalChars = s.length();

        while (result.length() < totalChars) {
            // Ascending pass
            for (int i = 0; i < 26; i++) {
                if (counts[i] > 0) {
                    result.append((char) ('a' + i));
                    counts[i]--;
                }
            }

            // Descending pass
            for (int i = 25; i >= 0; i--) {
                if (counts[i] > 0) {
                    result.append((char) ('a' + i));
                    counts[i]--;
                }
            }
        }

        return result.toString();
    }
}