class Solution {
    public String customSortString(String order, String s) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        StringBuilder sb = new StringBuilder();
        for (char c : order.toCharArray()) {
            while (counts[c - 'a'] > 0) {
                sb.append(c);
                counts[c - 'a']--;
            }
        }

        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            while (counts[i] > 0) {
                sb.append(c);
                counts[i]--;
            }
        }

        return sb.toString();
    }
}