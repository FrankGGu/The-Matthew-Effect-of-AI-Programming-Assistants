class Solution {
    public String customSortString(String order, String s) {
        int[] count = new int[26];
        StringBuilder result = new StringBuilder();

        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        for (char c : order.toCharArray()) {
            while (count[c - 'a'] > 0) {
                result.append(c);
                count[c - 'a']--;
            }
        }

        for (int i = 0; i < 26; i++) {
            while (count[i] > 0) {
                result.append((char) (i + 'a'));
                count[i]--;
            }
        }

        return result.toString();
    }
}