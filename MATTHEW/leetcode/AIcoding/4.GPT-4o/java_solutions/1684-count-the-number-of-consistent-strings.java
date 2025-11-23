class Solution {
    public int countConsistentStrings(String allowed, String[] words) {
        boolean[] charSet = new boolean[26];
        for (char c : allowed.toCharArray()) {
            charSet[c - 'a'] = true;
        }
        int count = 0;
        for (String word : words) {
            boolean isConsistent = true;
            for (char c : word.toCharArray()) {
                if (!charSet[c - 'a']) {
                    isConsistent = false;
                    break;
                }
            }
            if (isConsistent) {
                count++;
            }
        }
        return count;
    }
}